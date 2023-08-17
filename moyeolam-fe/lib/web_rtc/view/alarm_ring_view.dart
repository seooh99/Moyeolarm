import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:moyeolam/common/button/btn_call.dart';
import 'package:moyeolam/common/const/colors.dart';
import 'package:moyeolam/web_rtc/view/real_time_view.dart';
import 'package:moyeolam/web_rtc/view/web_rtc_room_view.dart';
import 'package:moyeolam/web_rtc/viewmodel/alarm_ring_view_model.dart';

import '../../common/const/openvidu_confiig.dart';
import '../../common/secure_storage/secure_storage.dart';
import '../../main.dart';
import '../../user/model/user_model.dart';
import '../model/connection.dart';

class AlarmRingView extends StatefulWidget {
  final int alarmGroupId;

  const AlarmRingView({super.key, required this.alarmGroupId});

  @override
  State<AlarmRingView> createState() => _AlarmRingViewState();
}

class _AlarmRingViewState extends State<AlarmRingView> {
  final TimeService _timeService = TimeService();

  // 유저 정보
  UserInformation _userInformation = UserInformation(storage);

  final Dio _dio = Dio();

  final TextEditingController _textSessionController = TextEditingController();
  final TextEditingController _textUserNameController = TextEditingController();

  AudioPlayer player = AudioPlayer();

  Future audioPlayer() async {
    await player.setVolume(0.9);
    await player.setSpeed(1);
    await player.setAsset('assets/audio/alarm_sound.mp3');
    await player.setLoopMode(LoopMode.all);
    player.play();
  }

  Future<bool> _createSession() async {
    try {
      var response = await _dio.post(
        '/sessions',
        data: {
          "mediaMode": "ROUTED",
          "recordingMode": "MANUAL",
          "customSessionId": _textSessionController.text,
          "forcedVideoCodec": "VP8",
          "allowTranscoding": false
        },
      );
      final statusCode = response.statusCode ?? 400;
      if (statusCode >= 200 && statusCode < 300) {
        return true;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        return true;
      }
      print(e);
    }
    return false;
  }

  _connect(BuildContext ctx) async {
    final nav = Navigator.of(ctx);
    bool sessionCreated = await _createSession();

    if (!sessionCreated) {
      return;
    }

    try {
      var response = await _dio.post(
        '/sessions/${_textSessionController.text}/connection',
        data: {
          "type": "WEBRTC",
          "data": "My Server Data",
          "role": "PUBLISHER",
        },
      );
      final statusCode = response.statusCode ?? 400;
      if (statusCode >= 200 && statusCode < 300) {
        print(response.data);
        final connection = Connection.fromJson(response.data);
        await nav.push(
          MaterialPageRoute(
              builder: (_) => WebRtcRoomView(
                    room: connection,
                    userName: _textUserNameController.text,
                    alarmGroupId: widget.alarmGroupId,
                  )),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    _dio.options.baseUrl = '$OPENVIDU_URL/openvidu/api';
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["authorization"] =
        'Basic ${base64Encode(utf8.encode('OPENVIDUAPP:$OPENVIDU_SECRET'))}';

    // _textSessionController.text = 'Session${Random().nextInt(1000)}';
    // _textUserNameController.text = 'Participant${Random().nextInt(1000)}';

    _textSessionController.text = widget.alarmGroupId.toString();

    audioPlayer();
    _getUserInfo();
  }

  _getUserInfo() async {
    UserModel? userInfo = await _userInformation.getUserInfo();
    _textUserNameController.text = userInfo?.nickname ?? 'Participant${Random().nextInt(1000)}';
  }

  @override
  void dispose() {
    super.dispose();
    player.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // 날짜
          RealTimeClock(
            streamMethod: _timeService.currentDateStream(),
            isTime: false,
          ),
          // 시간
          RealTimeClock(
            streamMethod: _timeService.currentTimeStream(),
            isTime: true,
          ),
          const SizedBox(
            width: 200,
            height: 120,
          ),
          Container(
            width: 200,
            height: 200,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.asset("assets/gif/moyeolam.gif"),
            ),
          ),

          // /* ===== test ===== */
          // Container(
          //   margin: EdgeInsets.fromLTRB(0, 10, 0, 13),
          //   child: SizedBox(
          //     width: 280,
          //     child: TextField(
          //       style: const TextStyle(color: Colors.white),
          //       controller: _textSessionController,
          //       decoration: const InputDecoration(
          //         suffixStyle: TextStyle(color: Colors.white),
          //         border: OutlineInputBorder(),
          //         filled: true,
          //         fillColor: Colors.deepPurple,
          //         labelText: "Room name",
          //         labelStyle: TextStyle(color: Colors.white),
          //       ),
          //     ),
          //   ),
          // ),
          //
          // Container(
          //   padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          //   child: SizedBox(
          //     width: 280,
          //     child: TextField(
          //       style: const TextStyle(color: Colors.white),
          //       controller: _textUserNameController,
          //       decoration: const InputDecoration(
          //         suffixStyle: TextStyle(color: Colors.white),
          //         border: OutlineInputBorder(),
          //         filled: true,
          //         fillColor: Colors.deepPurple,
          //         labelText: "Username",
          //         labelStyle: TextStyle(color: Colors.white),
          //       ),
          //     ),
          //   ),
          // ),
          // /* ==== test ==== */

          const SizedBox(
            width: 200,
            height: 120,
          ),
          BtnCalling(
              icons: Icon(Icons.call), onPressed: () => _connect(context)),
          const SizedBox(
            width: 200,
            height: 120,
          ),
        ],
      ),
    );
  }
}
