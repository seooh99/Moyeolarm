import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final alarmStateProvider = StateNotifierProvider<AlarmState, int?>((ref) {
  return AlarmState();
});

class AlarmState extends StateNotifier<int?>{
  AlarmState() : super(null);

  int? get callbackAlarmId => state;

  bool get isFired => state != null;

  void fire(int alarmId) {
    state = alarmId;
    debugPrint('Alarm has fired #$alarmId');
  }

  void dismiss() {
    state = null;
  }
}

