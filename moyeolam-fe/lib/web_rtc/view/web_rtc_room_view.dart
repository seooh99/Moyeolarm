import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:openvidu_client/openvidu_client.dart';
import 'package:youngjun/common/button/btn_call.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/web_rtc/component/config_view.dart';
import 'package:youngjun/web_rtc/model/connection.dart';
import 'package:youngjun/web_rtc/model/face_recognition_model.dart';
import 'package:youngjun/web_rtc/repository/face_recognition_repository.dart';

import '../../common/const/openvidu_confiig.dart';
import '../component/media_stream_view.dart';

class WebRtcRoomView extends StatefulWidget {
  final Connection room;
  final String userName;

  const WebRtcRoomView({super.key, required this.room, required this.userName});

  @override
  State<WebRtcRoomView> createState() => _WebRtcRoomViewState();
}

class _WebRtcRoomViewState extends State<WebRtcRoomView> {
  Map<String, RemoteParticipant> remoteParticipants = {};
  bool localPressed = false;
  Map<String, bool> remotePressed = {};
  MediaDeviceInfo? input;
  bool isInside = false;
  late OpenViduClient _openvidu;

  MemoryImage? _image;
  ByteBuffer? _bf;

  LocalParticipant? localParticipant;

  @override
  void initState() {
    super.initState();
    initOpenVidu();
    _listenSessionEvents();
  }

  Future<void> initOpenVidu() async {
    _openvidu = OpenViduClient("$OPENVIDU_URL/openvidu");
    localParticipant =
        await _openvidu.startLocalPreview(context, StreamMode.frontCamera);
    localParticipant?.publishAudio(false);
    setState(() {});
  }

  void _listenSessionEvents() {
    _openvidu.on(OpenViduEvent.userJoined, (params) async {
      await _openvidu.subscribeRemoteStream(params["id"]);
    });

    _openvidu.on(OpenViduEvent.userPublished, (params) {
      _openvidu.subscribeRemoteStream(params["id"],
          video: params["videoActive"], audio: params["audioActive"]);
    });

    _openvidu.on(OpenViduEvent.addStream, (params) {
      remoteParticipants = {..._openvidu.participants};
      remotePressed =
          _openvidu.participants.keys.fold(<String, bool>{}, (res, id) {
        res[id] = false;
        return res;
      });
      setState(() {});
    });

    _openvidu.on(OpenViduEvent.removeStream, (params) {
      remoteParticipants = {..._openvidu.participants};
      remotePressed =
          _openvidu.participants.keys.fold(<String, bool>{}, (res, id) {
        res[id] = false;
        return res;
      });
      setState(() {});
    });

    _openvidu.on(OpenViduEvent.publishVideo, (params) {
      remoteParticipants = {..._openvidu.participants};
      remotePressed =
          _openvidu.participants.keys.fold(<String, bool>{}, (res, id) {
        res[id] = false;
        return res;
      });
      setState(() {});
    });

    _openvidu.on(OpenViduEvent.publishAudio, (params) {
      remoteParticipants = {..._openvidu.participants};
      remotePressed =
          _openvidu.participants.keys.fold(<String, bool>{}, (res, id) {
        res[id] = false;
        return res;
      });
      setState(() {});
    });

    _openvidu.on(OpenViduEvent.updatedLocal, (params) {
      localParticipant = params['localParticipant'];
      setState(() {});
    });

    _openvidu.on(OpenViduEvent.reciveMessage, (params) {
      String? from = params["from"];

      if (remoteParticipants.containsKey(from)) {
        remotePressed.update(from!, (value) => true);
        setState(() {});
        if (localPressed && !remotePressed.containsValue(false)) {
          _onDisconnect();
        }
      }
    });

    _openvidu.on(OpenViduEvent.userUnpublished, (params) {
      remoteParticipants = {..._openvidu.participants};
      remotePressed =
          _openvidu.participants.keys.fold(<String, bool>{}, (res, id) {
        res[id] = false;
        return res;
      });
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
    _image = MemoryImage(_bf!.asUint8List());

    setState(() {});
  }

  Future<bool> _faceRecognition() async {
    var multipartFile = MultipartFile.fromBytes(_bf!.asUint8List().cast<int>(),
        filename: 'image');
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
                            // height: 580,
                            height: 160,
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
                                    width: 170,
                                    height: 170,
                                    child: MediaStreamView(
                                      borderRadius: BorderRadius.circular(15),
                                      participant: localParticipant!,
                                    ),
                                  ),
                                ),
                                ...remoteParticipants.values
                                    .map((remote) => Container(
                                        margin: EdgeInsets.all(10),
                                        child: SizedBox(
                                          width: 170,
                                          height: 170,
                                          child: MediaStreamView(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            participant: remote,
                                          ),
                                        ))),
                              ],
                            ),
                          ),
                          _image == null
                              ? Container()
                              : Container(
                                  height: 170,
                                  width: 460,
                                  child: Image(image: _image!),
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
                                child: Text("비상탈출"),
                              ),
                              BtnCalling(
                                icons: Icon(Icons.call_end),
                                backGroundColor: CALLOFF_COLOR,
                                onPressed: () async {
                                  await _captureImage();
                                  bool faceRecognitionResult =
                                      await _faceRecognition();

                                  if (faceRecognitionResult) {
                                    _openvidu.sendMessage(
                                        OvMessage.fromJson(<String, dynamic>{
                                      "data": "true",
                                      "type": "success"
                                    }));
                                    setState(() {
                                      localPressed = true;
                                    });
                                  }

                                  // if (!remotePressed.containsValue(false)) {
                                  //   _onDisconnect();
                                  // }
                                },
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
