import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:youngjun/alarm/view/alarm_add_page.dart';
import 'package:youngjun/alarm/viewmodel/alarm_detail_view_model.dart';
import 'package:youngjun/common/const/colors.dart';
import '../component/alarm_list.dart';
import '../model/alarm_list_model.dart';
import '../viewmodel/alarm_list_view_model.dart';
import 'alarm_detail_page.dart';

class MainAlarmList extends ConsumerStatefulWidget {
  const MainAlarmList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainAlarmListState();


}

class _MainAlarmListState extends ConsumerState<MainAlarmList> {

  @override
  Widget build(BuildContext context) {
    AsyncValue<AlarmListModel> alarmgroups = ref.watch(alarmListProvider);
    return RefreshIndicator(
      onRefresh: ()async{
        ref.refresh(alarmListProvider);
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 68),
        child: alarmgroups.when(data: (data) {
          if (data != null && data.alarmGroups != null) {
            var alarmGroups = data.alarmGroups;
            return MaterialApp(
              home: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var alarmGroup in alarmGroups)
                      GestureDetector(
                        onTap: () async{
                          // Navigator.of(context).pushNamed("/alarm_group_detail ", arguments: alarmGroup.alarmGroupId);
                          var response = await AlarmListDetailViewModel().getAlarmListDetail(alarmGroup.alarmGroupId);
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => AlarmDetailScreen(alarmGroup: response,)),

                          ).then((value) {setState(() { });});
                        },
                        child: AlarmList(
                          alarmGroupId: alarmGroup.alarmGroupId!,
                          hour: alarmGroup.hour!,
                          minute: alarmGroup.minute!,
                          toggle: alarmGroup.toggle!,
                          title: alarmGroup.title!,
                          weekday: alarmGroup.dayOfWeek!,
                        ),
                      ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        print("눌림");
                        // Navigator.pushNamed(context, "/add_alarm_group");
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> AlarmAddScreen()))
                        .then((value) {setState(() {
                            ref.refresh(alarmListProvider);
                        });});
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
      ),
    );
  }
}