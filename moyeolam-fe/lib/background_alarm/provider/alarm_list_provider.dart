
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/background_alarm/model/alarm.dart';
import 'package:youngjun/background_alarm/service/alarm_file_handler.dart';

final alarmFileProvider = FutureProvider<List<Alarm>>((ref) async {
  final List<Alarm> alarms = await AlarmFileHandler().read() ?? [];
  return alarms;
});

final alarmListProvider = StateNotifierProvider<AlarmListNotifier, List<Alarm>>((ref) {
  List<Alarm> alarms = [];

  ref.watch(alarmFileProvider).when(data: (data){
    alarms = data;
  }, error: (error, stackTrace){

  }, loading: (){});

  return AlarmListNotifier(alarms);
});

class AlarmListNotifier extends StateNotifier<List<Alarm>> {
  AlarmListNotifier(super.state);

  final AlarmFileHandler _fileHandler = AlarmFileHandler();

  int get length => state.length;

  Alarm operator [](int index) {
    assert(0 <= index && index < state.length);
    return state[index];
  }

  Future<void> _updateFile() async {
    await _fileHandler.write(state);
  }

  void add(Alarm newAlarm) {
    state = [...state, newAlarm];
    _updateFile();
  }

  void remove(Alarm removeAlarm) {
    state = state.where((alarm) => alarm != removeAlarm).toList();
    _updateFile();
  }

  void replace(Alarm oldAlarm, Alarm newAlarm) {
    state = state.map((alarm) {
      if (alarm == oldAlarm) {
        return newAlarm;
      } else {
        return alarm;
      }
    }).toList();

    _updateFile();
  }

  int getAvailableAlarmId() {
    int id = 14;
    for (final alarm in state) {
      if (alarm.id != id) {
        break;
      }
      id = id + 7;
    }
    return id;
  }

  Alarm? getAlarmBy(int callbackId) {
    for (Alarm alarm in state) {
      final id = (callbackId / 7).floor() * 7;

      if (id == alarm.id) {
        return alarm;
      }
    }
    return null;
  }
}
