import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:youngjun/common/const/colors.dart';
import '../component/alarm_list.dart';
import '../model/alarm_list_model.dart';
import '../viewmodel/alarm_list_view_model.dart';

class MainAlarmList extends ConsumerWidget {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final HideNavBar hiding = HideNavBar();

    AsyncValue<AlarmListModel> alarmgroups = ref.watch(alarmListProvider);

    return Padding(
      padding: EdgeInsets.only(bottom: 68),
      child: alarmgroups.when(data: (data) {
        if (data != null && data.alarmGroups != null) {
          var alarmGroups = data.alarmGroups;
          return SingleChildScrollView(
            child: Column(
              children: [
                for (var alarmGroup in alarmGroups)
                  AlarmList(
                    alarmGroupId: alarmGroup.alarmGroupId!,
                    hour: alarmGroup.hour!,
                    minute: alarmGroup.minute!,
                    toggle: alarmGroup.toggle!,
                    title: alarmGroup.title!,
                    weekday: [],
                    onTap: () =>
                        {Navigator.pushNamed(context, "/alarm_group_detail")},
                  ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    print("눌림");
                  },
                  child: Card(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                        style: BorderStyle.solid,
                        color: MAIN_COLOR,
                      ),
                    ),
                    color: BACKGROUND_COLOR,
                    child: const Center(
                      heightFactor: 2,
                      child: Text(
                        "+",
                        style: TextStyle(
                          color: MAIN_COLOR,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Text("값이 없습니다."),
          );
        }
      }, error: (error, stackTrace) {
        return Text("$error");
      }, loading: () {
        return SpinKitFadingCube(
          // FadingCube 모양 사용
          color: Colors.blue, // 색상 설정
          size: 50.0, // 크기 설정
          duration: Duration(seconds: 2), //속도 설정
        );
      }),
    );
  }
}
