import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moyeolam/background_alarm/model/alarm.dart';
import 'package:moyeolam/background_alarm/provider/alarm_state.dart';
import 'package:moyeolam/background_alarm/service/alarm_scheduler.dart';
import 'package:moyeolam/main/view/main_page.dart';
import 'package:openvidu_client/openvidu_client.dart';
import 'package:moyeolam/alarm/model/alarm_detail_model.dart';
import 'package:moyeolam/alarm/repository/alarm_list_repository.dart';
import 'package:moyeolam/common/button/btn_call.dart';
import 'package:moyeolam/common/const/colors.dart';
import 'package:moyeolam/web_rtc/component/config_view.dart';
import 'package:moyeolam/web_rtc/model/alarm_group_member.dart';
import 'package:moyeolam/web_rtc/model/connection.dart';
import 'package:moyeolam/web_rtc/model/face_recognition_model.dart';
import 'package:moyeolam/web_rtc/repository/face_recognition_repository.dart';

import '../../common/const/openvidu_confiig.dart';
import '../component/media_stream_view.dart';

class WebRtcRoomView extends ConsumerStatefulWidget {
  final Connection room;
  final String userName;
  final int alarmGroupId;
  final Alarm alarm;

  const WebRtcRoomView(
      {super.key,
      required this.room,
      required this.userName,
      required this.alarmGroupId,
      required this.alarm});

  @override
  ConsumerState<WebRtcRoomView> createState() => _WebRtcRoomViewState();
}

class _WebRtcRoomViewState extends ConsumerState<WebRtcRoomView> with WidgetsBindingObserver {
  /// map of SID to RemoteParticipant
  Map<String, RemoteParticipant> remoteParticipants = {};

  /// map of nickname to MemberState
  Map<String, MemberState> remoteMemberState = {};

  /// map of nickname to AlarmGroupMember
  Map<String, AlarmGroupMember> alarmGroupMembers = {};

  MemberState localState = MemberState.offline;
  bool isInside = false;
  late OpenViduClient _openvidu;
  LocalParticipant? localParticipant;

  ByteBuffer? _bf;

  late Timer _timer;
  bool isAllRecognized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initOpenVidu();
    initAlarmDetail();
    _listenSessionEvents();
    _start();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   switch (state) {
  //     case AppLifecycleState.paused:
  //       _dismissAlarm();
  //       break;
  //     default:
  //   }
  // }

  void _dismissAlarm() async {
    // final alarmState = context.read<AlarmState>();
    final _ = ref.watch(alarmStateProvider);
    final alarmState = ref.watch(alarmStateProvider.notifier);

    final callbackAlarmId = alarmState.callbackAlarmId;

    if(callbackAlarmId == null){
      return;
    }
    // 알람 콜백 ID는 `AlarmScheduler`에 의해 일(0), 월(1), 화(2), ... , 토요일(6) 만큼 더해져 있다.
    // 따라서 이를 7로 나눈 몫이 해당 요일을 나타낸다.
    final firedAlarmWeekday = callbackAlarmId % 7;
    final nextAlarmTime =
    widget.alarm.timeOfDay.toComingDateTimeAt(firedAlarmWeekday);

    await AlarmScheduler.reschedule(callbackAlarmId, nextAlarmTime);

    alarmState.dismiss();
  }

  @override
  void dispose() {
    _timer.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _start() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      await _captureImage();
      bool faceRecognitionResult = await _faceRecognition();

      if (faceRecognitionResult) {
        if (localState == MemberState.online) {
          _openvidu.sendMessage(OvMessage.fromJson(
              <String, dynamic>{"data": "true", "type": "recognized"}));

          setState(() {
            localState = MemberState.recognized;
          });

          // int invalidMemberCnt = alarmGroupMembers.values
          //     .where((member) => member.memberState != MemberState.recognized)
          //     .length;
          //
          // if (invalidMemberCnt == 0) {
          //   print("invalidMemberCnt: $invalidMemberCnt");
          //   setState(() {
          //     isAllRecognized = true;
          //   });
          // }

          int recognizedMemberCnt = remoteMemberState.values.where((state) => state == MemberState.recognized).length;

          if (recognizedMemberCnt == alarmGroupMembers.length) {
            isAllRecognized = true;
          }
        }
      } else {
        if (localState == MemberState.recognized) {
          _openvidu.sendMessage(OvMessage.fromJson(
              <String, dynamic>{"data": "false", "type": "recognized"}));

          setState(() {
            localState = MemberState.online;
          });
        }
      }
    });
  }

  Future<void> initOpenVidu() async {
    _openvidu = OpenViduClient("$OPENVIDU_URL/openvidu");
    localParticipant =
        await _openvidu.startLocalPreview(context, StreamMode.frontCamera);
    localState = MemberState.online;
    setState(() {});
  }

  Future<void> initAlarmDetail() async {
    final AlarmListRepository alarmListRepository = AlarmListRepository();
    AlarmDetailResponseModel alarmDetailResponseModel =
        await alarmListRepository.getAlarmListDetail(widget.alarmGroupId);
    alarmDetailResponseModel.data.alarmGroup.members
        .where((member) => member.nickname != widget.userName && member.toggle)
        .forEach((member) {
      alarmGroupMembers[member.nickname] = AlarmGroupMember(
          memberId: member.memberId, nickname: member.nickname);
    });

    setState(() {});
  }

  void _listenSessionEvents() {
    _openvidu.on(OpenViduEvent.userJoined, (params) async {
      await _openvidu.subscribeRemoteStream(params["id"]);
    });

    _openvidu.on(OpenViduEvent.userPublished, (params) {
      _openvidu.subscribeRemoteStream(params["id"],
          video: params["videoActive"], audio: params["audioActive"], speakerphone: true);
    });

    _openvidu.on(OpenViduEvent.addStream, (params) {
      remoteParticipants = {..._openvidu.participants};

      // remoteParticipants.forEach((SID, remote) {
      //   String nickname = remote.metadata?['clientData'];
      //
      //   if (alarmGroupMembers[nickname]?.memberState == MemberState.offline) {
      //     alarmGroupMembers[nickname]?.memberState = MemberState.online;
      //     alarmGroupMembers[nickname]?.SID = SID;
      //   }
      // });

      remoteMemberState = _openvidu.participants.values.fold(<String, MemberState>{}, (previousValue, remote) {
        String nickname = remote.metadata?['clientData'];

        remoteMemberState.containsKey(nickname)
        ? previousValue[nickname] = remoteMemberState[nickname] ?? MemberState.online
        : previousValue[nickname] = MemberState.online;

        return previousValue;
      });

      setState(() {});
    });

    _openvidu.on(OpenViduEvent.removeStream, (params) {
      remoteParticipants = {..._openvidu.participants};

      // Set<String> onlineNicknames =
      //     remoteParticipants.values.fold({}, (res, remote) {
      //   String nickname = remote.metadata?['clientData'];
      //   res.add(nickname);
      //   return res;
      // });
      //
      // for (String nickname in alarmGroupMembers.keys) {
      //   if (!onlineNicknames.contains(nickname)) {
      //     alarmGroupMembers[nickname]?.memberState = MemberState.offline;
      //     alarmGroupMembers[nickname]?.SID = null;
      //   }
      // }

      Set<String> onlineNicknames =
          remoteParticipants.values.fold({}, (res, remote) {
        String nickname = remote.metadata?['clientData'];
        res.add(nickname);
        return res;
      });

      Map<String, MemberState> newRemoteMemberState = {};

      remoteMemberState.forEach((nickname, memberState) {
        if (onlineNicknames.contains(nickname)) {
          newRemoteMemberState[nickname] = memberState;
        }
      });

      remoteMemberState = newRemoteMemberState;

      setState(() {});
    });

    _openvidu.on(OpenViduEvent.publishVideo, (params) {
      remoteParticipants = {..._openvidu.participants};
      setState(() {});
    });

    _openvidu.on(OpenViduEvent.publishAudio, (params) {
      remoteParticipants = {..._openvidu.participants};
      setState(() {});
    });

    _openvidu.on(OpenViduEvent.updatedLocal, (params) {
      localParticipant = params['localParticipant'];
      setState(() {});
    });

    _openvidu.on(OpenViduEvent.reciveMessage, (params) {
      // String? from = params["from"];
      // String? type = params["type"];
      // String? data = params["data"];
      // String nickname = remoteParticipants[from]?.metadata?['clientData'];
      //
      // if (data == 'true') {
      //   alarmGroupMembers[nickname]?.memberState = MemberState.recognized;
      // } else if (data == 'false') {
      //   alarmGroupMembers[nickname]?.memberState = MemberState.online;
      // }
      // setState(() {});
      //
      // int invalidMemberCnt = alarmGroupMembers.values
      //     .where((member) => member.memberState != MemberState.recognized)
      //     .length;
      //
      // print('invalidMemberCnt: $invalidMemberCnt');
      //
      // if (localState == MemberState.recognized && invalidMemberCnt == 0) {
      //   isAllRecognized = true;
      // }

      String? from = params["from"];
      String? type = params["type"];
      String? data = params["data"];
      String? nickname = remoteParticipants[from]?.metadata?['clientData'];

      if (data == 'true') {
        remoteMemberState[nickname!] = MemberState.recognized;
      } else if (data == 'false') {
        remoteMemberState[nickname!] = MemberState.online;
      }

      int recognizedMemberCnt = remoteMemberState.values.where((state) => state == MemberState.recognized).length;

      if (localState == MemberState.recognized && recognizedMemberCnt == alarmGroupMembers.length) {
        isAllRecognized = true;
      }

      setState(() {});
    });

    _openvidu.on(OpenViduEvent.userUnpublished, (params) {
      remoteParticipants = {..._openvidu.participants};
      setState(() {});
    });

    _openvidu.on(OpenViduEvent.error, (params) {});
  }

  Future<void> _onConnect() async {
    final dio = Dio();
    dio.options.baseUrl = '$OPENVIDU_URL/openvidu/api';
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] =
        'Basic ${base64Encode(utf8.encode('OPENVIDUAPP:$OPENVIDU_SECRET'))}';
    try {
      var response = await dio.post(
        '/sessions/${widget.room.sessionId}/connection',
        data: {"type": widget.room.type, "role": "PUBLISHER", "record": false},
      );
      final statusCode = response.statusCode ?? 400;
      if (statusCode >= 200 && statusCode < 300) {
        final connection = Connection.fromJson(response.data);
        localParticipant = await _openvidu.publishLocalStream(
            token: connection.token!, userName: widget.userName);
        setState(() {
          isInside = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void _onDisconnect() async {
    final nav = Navigator.of(context);
    await _openvidu.disconnect();
    _timer.cancel();
    _dismissAlarm();
    SystemNavigator.pop();
    // nav.push(MaterialPageRoute(builder: (_) => const MainPage()));
  }

  Future<void> _captureImage() async {
    MediaStreamTrack? track = localParticipant?.stream?.getVideoTracks().first;
    _bf = await track?.captureFrame();
    setState(() {});
  }

  Future<bool> _faceRecognition() async {
    var multipartFile = MultipartFile.fromBytes(_bf!.asUint8List().cast<int>(),
        filename: '${widget.userName}_image');
    ResponseFaceRecognitionModel responseFaceRecognitionModel =
        await FaceRecognitionRepository().faceRecognition(multipartFile);
    return responseFaceRecognitionModel.data.result;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: BACKGROUND_COLOR,
          body: localParticipant == null
              ? Container()
              : !isInside
                  ? ConfigView(
                      participant: localParticipant!,
                      onConnect: _onConnect,
                    )
                  : Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Center(
                            child: Column(
                          children: [
                            Container(
                              height: 580,
                              width: 355,
                              child: Wrap(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.start,
                                spacing: 5,
                                runSpacing: 5,
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: SizedBox(
                                      width: 155,
                                      height: 155,
                                      child: MediaStreamView(
                                        borderRadius: BorderRadius.circular(15),
                                        participant: localParticipant!,
                                        userName: widget.userName,
                                        memberState: localState,
                                      ),
                                    ),
                                  ),
                                  // ...alarmGroupMembers.values
                                  //     .map((member) => Container(
                                  //         margin: EdgeInsets.all(10),
                                  //         child: SizedBox(
                                  //             width: 155,
                                  //             height: 155,
                                  //             child: MediaStreamView(
                                  //               borderRadius:
                                  //                   BorderRadius.circular(15),
                                  //               participant: remoteParticipants[
                                  //                   member.SID],
                                  //               userName: member.nickname,
                                  //               memberState: member.memberState,
                                  //             )))),
                                  ...remoteParticipants.values
                                      .map((remote) => Container(
                                      margin: EdgeInsets.all(10),
                                      child: SizedBox(
                                        width: 155,
                                        height: 155,
                                        child: MediaStreamView(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          participant: remote,
                                          userName: remote.metadata?['clientData'],
                                          memberState: remoteMemberState[remote.metadata?['clientData']],
                                        ),
                                      ))),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),
                                ElevatedButton(
                                  onPressed: _onDisconnect,
                                  child: const Text("비상탈출"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: CALLOFF_COLOR,
                                  ),
                                ),
                                isAllRecognized
                                    ? BtnCalling(
                                        icons: const Icon(Icons.call_end),
                                        backGroundColor: CALLOFF_COLOR,
                                        onPressed: _onDisconnect,
                                      )
                                    : BtnCalling(
                                        icons: const Icon(Icons.call_end),
                                        backGroundColor: CKECK_GRAY_COLOR,
                                        onPressed: () {},
                                      ),
                              ],
                            )
                          ],
                        )),
                      )
        ));
  }
}
