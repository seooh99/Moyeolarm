import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:moyeolam/background_alarm/model/alarm.dart';
import 'package:moyeolam/background_alarm/provider/alarm_state.dart';
import 'package:moyeolam/background_alarm/service/alarm_scheduler.dart';

AudioPlayer player = AudioPlayer();

Future audioPlayer() async {
  await player.setVolume(75);
  await player.setSpeed(1);
  await player.setAsset('assets/audio/sound.mp3');
  player.play();
}

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key, required this.alarm}) : super(key: key);

  final Alarm alarm;

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    print("알람실행!!");
    // TODO: 음악 재생하기
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        _dismissAlarm();
        break;
      default:
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _dismissAlarm() async {
    final alarmState = context.read<AlarmState>();
    final callbackAlarmId = alarmState.callbackAlarmId!;
    // 알람 콜백 ID는 `AlarmScheduler`에 의해 일(0), 월(1), 화(2), ... , 토요일(6) 만큼 더해져 있다.
    // 따라서 이를 7로 나눈 몫이 해당 요일을 나타낸다.
    final firedAlarmWeekday = callbackAlarmId % 7 - 1;
    final nextAlarmTime =
        widget.alarm.timeOfDay.toComingDateTimeAt(firedAlarmWeekday);

    await AlarmScheduler.reschedule(callbackAlarmId, nextAlarmTime);

    alarmState.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    audioPlayer();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '알람 화면',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextButton(
              onPressed: _dismissAlarm,
              child: const Text('알람 해제'),
            ),
          ],
        ),
      ),
    );
  }
}
