
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class TimeService {
  // 현재 시간을 갱신하고 반환하는 Stream을 생성합니다.
  Stream<DateTime> currentTimeStream() async* {
    while (true) {
      await Future.delayed(Duration(minutes: 1));
      yield DateTime.now();
    }
  }
  Stream<DateTime> currentDateStream() async*{
    while(true){
      await Future.delayed(Duration(days: 1));
      yield DateTime.now();
    }
  }
}


