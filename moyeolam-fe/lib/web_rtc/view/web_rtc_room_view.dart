import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:openvidu_client/openvidu_client.dart';
import 'package:youngjun/alarm/model/alarm_detail_model.dart';
import 'package:youngjun/alarm/repository/alarm_list_repository.dart';
import 'package:youngjun/common/button/btn_call.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/web_rtc/component/config_view.dart';
import 'package:youngjun/web_rtc/model/alarm_group_member.dart';
import 'package:youngjun/web_rtc/model/connection.dart';
import 'package:youngjun/web_rtc/model/face_recognition_model.dart';
import 'package:youngjun/web_rtc/repository/face_recognition_repository.dart';

import '../../common/const/openvidu_confiig.dart';
import '../component/media_stream_view.dart';

class WebRtcRoomView extends StatefulWidget {
  final Connection room;
  final String userName;
  final int alarmGroupId;

  const WebRtcRoomView(
      {super.key,
      required this.room,
      required this.userName,
      required this.alarmGroupId});

  @override
  State<WebRtcRoomView> createState() => _WebRtcRoomViewState();
}

class _WebRtcRoomViewState extends State<WebRtcRoomView> {
  /// map of SID to RemoteParticipant
  Map<String, RemoteParticipant> remoteParticipants = {};

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
    initOpenVidu();
    initAlarmDetail();
    _listenSessionEvents();
    _start();
  }

  @override
  void dispose() {
    _timer.cancel();
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

          int invalidMemberCnt = alarmGroupMembers.values
              .where((member) => member.memberState != MemberState.recognized)
              .length;

          if (invalidMemberCnt == 0) {
            print("invalidMemberCnt: $invalidMemberCnt");
            setState(() {
              isAllRecognized = true;
            });
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

      remoteParticipants.forEach((SID, remote) {
        String nickname = remote.metadata?['clientData'];

        if (alarmGroupMembers[nickname]?.memberState == MemberState.offline) {
          alarmGroupMembers[nickname]?.memberState = MemberState.online;
          alarmGroupMembers[nickname]?.SID = SID;
        }
      });

      setState(() {});
    });

    _openvidu.on(OpenViduEvent.removeStream, (params) {
      remoteParticipants = {..._openvidu.participants};

      print("participants removed");

      Set<String> onlineNicknames =
          remoteParticipants.values.fold({}, (res, remote) {
        String nickname = remote.metadata?['clientData'];
        res.add(nickname);
        return res;
      });

      for (String nickname in alarmGroupMembers.keys) {
        if (!onlineNicknames.contains(nickname)) {
          alarmGroupMembers[nickname]?.memberState = MemberState.offline;
          alarmGroupMembers[nickname]?.SID = null;
        }
      }

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
      String? from = params["from"];
      String? type = params["type"];
      String? data = params["data"];
      String nickname = remoteParticipants[from]?.metadata?['clientData'];

      if (data == 'true') {
        alarmGroupMembers[nickname]?.memberState = MemberState.recognized;
      } else if (data == 'false') {
        alarmGroupMembers[nickname]?.memberState = MemberState.online;
      }
      setState(() {});

      int invalidMemberCnt = alarmGroupMembers.values
          .where((member) => member.memberState != MemberState.recognized)
          .length;

      print('invalidMemberCnt: $invalidMemberCnt');

      if (localState == MemberState.recognized && invalidMemberCnt == 0) {
        isAllRecognized = true;
      }
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
    nav.pop();
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
                      child: Column(
                        children: [
                          Container(
                            height: 580,
                            width: 386,
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
                                ...alarmGroupMembers.values
                                    .map((member) => Container(
                                        margin: EdgeInsets.all(10),
                                        child: SizedBox(
                                            width: 155,
                                            height: 155,
                                            child: MediaStreamView(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              participant: remoteParticipants[
                                                  member.SID],
                                              userName: member.nickname,
                                              memberState: member.memberState,
                                            )))),
                                // ...remoteParticipants.values
                                //     .map((remote) => Container(
                                //     margin: EdgeInsets.all(10),
                                //     child: SizedBox(
                                //       width: 170,
                                //       height: 170,
                                //       child: MediaStreamView(
                                //         borderRadius:
                                //         BorderRadius.circular(15),
                                //         participant: remote,
                                //       ),
                                //     ))),
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
                              ),
                              isAllRecognized
                                  ? BtnCalling(
                                      icons: const Icon(Icons.call_end),
                                      backGroundColor: CALLOFF_COLOR,
                                      onPressed: () async {
                                        _onDisconnect();
                                        // await _captureImage();
                                        // bool faceRecognitionResult =
                                        //     await _faceRecognition();
                                        //
                                        // if (faceRecognitionResult) {
                                        //   _openvidu.sendMessage(
                                        //       OvMessage.fromJson(<String, dynamic>{
                                        //     "data": "true",
                                        //     "type": "recognized"
                                        //   }));
                                        //   setState(() {
                                        //     localState = MemberState.recognized;
                                        //   });
                                        //
                                        //   int invalidMemberCnt = alarmGroupMembers
                                        //       .values
                                        //       .where((member) =>
                                        //           member.memberState !=
                                        //           MemberState.recognized)
                                        //       .length;
                                        //
                                        //   print(
                                        //       'invalidMemberCnt: $invalidMemberCnt');
                                        //
                                        //   if (invalidMemberCnt == 0) {
                                        //     _onDisconnect();
                                        //   }
                                        // } else {
                                        //   _openvidu.sendMessage(
                                        //       OvMessage.fromJson(<String, dynamic>{
                                        //     "data": "false",
                                        //     "type": "recognized"
                                        //   }));
                                        //   setState(() {
                                        //     localState = MemberState.online;
                                        //   });
                                        // }
                                      },
                                    )
                                  : BtnCalling(
                                      icons: const Icon(Icons.call_end),
                                      backGroundColor: CKECK_GRAY_COLOR,
                                      onPressed: () {},
                                    ),
                              // Row(children: [
                              //   BtnMedia(
                              //     icons: Icon(Icons.mic, color: FONT_COLOR),
                              //     // icons: Icon(Icons.mic_off),
                              //     onPressed: () {},
                              //   ),
                              //   BtnCalling(
                              //     icons: Icon(Icons.call_end),
                              //     backGroundColor: CALLOFF_COLOR,
                              //     onPressed: () {},
                              //   ),
                              //   BtnMedia(
                              //     icons: const Icon(
                              //       Icons.videocam,
                              //       color: FONT_COLOR,
                              //     ),
                              //     // icons: Icon(Icons.videocam_off),
                              //     onPressed: () {},
                              //   ),
                              // ]),
                            ],
                          )
                        ],
                      )),
        ));
  }
}
