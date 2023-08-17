import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moyeolam/alarm/view/alarm_add_page.dart';
import 'package:moyeolam/alarm/viewmodel/alarm_detail_view_model.dart';
import 'package:moyeolam/background_alarm/model/alarm.dart';
import 'package:moyeolam/background_alarm/provider/alarm_list_provider.dart';
import 'package:moyeolam/background_alarm/service/alarm_scheduler.dart';
import 'package:moyeolam/common/const/colors.dart';
import 'package:moyeolam/common/layout/title_bar.dart';
import 'package:moyeolam/fcm/view/alert_list_view.dart';
import 'package:moyeolam/common/confirm.dart';
import 'package:moyeolam/alarm/component/alarm_list.dart';
import 'package:moyeolam/alarm/model/alarm_list_model.dart';
import 'package:moyeolam/alarm/viewmodel/alarm_list_view_model.dart';
import 'alarm_detail_page.dart';

class MainAlarmList extends ConsumerStatefulWidget {
  const MainAlarmList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainAlarmListState();
}

class _MainAlarmListState extends ConsumerState<MainAlarmList> {
  final AlarmListViewModel _alarmListViewModel = AlarmListViewModel();


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      ref.invalidate(alarmListProvider);
    });
    AsyncValue<AlarmListModel> alarmgroups = ref.watch(alarmListProvider);
    AlarmListNotifier alarmListNotifier =
        ref.watch(alarmSettingProvider.notifier);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: TitleBar(
          appBar: AppBar(),
          title: "모여람",
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(
                        MaterialPageRoute(builder: (context) => ArletListView()));

              },
              icon: Icon(Icons.notifications),
            )
          ],
        ),
        backgroundColor: BACKGROUND_COLOR,
        body: Padding(
          padding: EdgeInsets.only(bottom: 68),
          child: alarmgroups.when(
              data: (data) {
            var alarmGroups = data.alarmGroups;

            return MaterialApp(
              // debugShowCheckedModeBanner: false,
              home: RefreshIndicator(
                onRefresh: ()async {
                  ref.invalidate(alarmListProvider);
                },
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      for (var alarmGroup in alarmGroups)
                        GestureDetector(
                          onLongPress: () async {
                            showDialog(
                              context: context,
                              builder: (context) => ConfirmDialog(
                                title: alarmGroup.isHost?"알람 그룹 삭제":"알람 그룹 나가기",
                                content: alarmGroup.isHost?
                                "알람 그룹을 삭제하시겠습니까?":
                                "알람 그룹을 나가시겠습니까?",
                                okTitle: "삭제",
                                cancelTitle: "취소",
                                okOnPressed: () async {
                                  await _alarmListViewModel.deleteAlarmGroup(alarmGroup.alarmGroupId);
                                  ref.invalidate(alarmListProvider);
                                  // 삭제 시 알람 예약 삭제
                                  Alarm alarm = Alarm(
                                      alarmGroupId: alarmGroup.alarmGroupId,
                                      callbackId: alarmGroup.alarmGroupId * 7,
                                      weekday: alarmGroup.dayOfWeek,
                                      hour: alarmGroup.hour,
                                      minute: alarmGroup.minute,
                                      toggle: alarmGroup.toggle);
                                  alarmListNotifier.remove(alarm);
                                  AlarmScheduler.cancelRepeatable(alarm);
                                  Navigator.pop(context);
                                },
                                cancelOnPressed: (){
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          },
                          onTap: (){
                            // Navigator.of(context).pushNamed("/alarm_group_detail ", arguments: alarmGroup.alarmGroupId);
                            ref.read(alarmDetailProvider).setAlarmGroupId(alarmGroup.alarmGroupId);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AlarmDetailScreen(alarmGroupId: alarmGroup.alarmGroupId,)),

                            );
                          },
                          child: AlarmList(
                            alarmGroupId: alarmGroup.alarmGroupId,
                            hour: alarmGroup.hour,
                            minute: alarmGroup.minute,
                            toggle: alarmGroup.toggle,
                            title: alarmGroup.title,
                            weekday: alarmGroup.dayOfWeek,
                            toggleChanged: (bool value) async {
                              await _alarmListViewModel
                                  .updateAlarmToggle(alarmGroup.alarmGroupId);
                              ref.invalidate(alarmListProvider);

                              // 토글 버튼 알람 예약
                              Alarm alarm = Alarm(
                                  alarmGroupId: alarmGroup.alarmGroupId,
                                  callbackId: alarmGroup.alarmGroupId * 7,
                                  weekday: alarmGroup.dayOfWeek,
                                  hour: alarmGroup.hour,
                                  minute: alarmGroup.minute,
                                  toggle: alarmGroup.toggle);
                              alarmListNotifier.add(alarm);
                              if (value) {
                                await AlarmScheduler.scheduleRepeatable(alarm);
                              } else {
                                await AlarmScheduler.cancelRepeatable(alarm);
                              }
                            },
                          ),
                        ),
                      SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          // print("눌림");
                          // Navigator.pushNamed(context, "/add_alarm_group");
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AlarmAddScreen()))
                              .then((value) {
                            setState(() {
                              ref.invalidate(alarmListProvider);
                            });
                          });
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
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // print("눌림");
                          // Navigator.pushNamed(context, "/add_alarm_group");
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AlarmAddScreen()))
                              .then((value) {
                            setState(() {
                              ref.invalidate(alarmListProvider);
                            });
                          });
                        },
                        child: Card(

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              style: BorderStyle.solid,
                              color: SUB_COLOR,
                            ),
                          ),
                          color: BACKGROUND_COLOR,
                          child: const Center(
                            heightFactor: 2,
                            child: Text(
                              "+",
                              style: TextStyle(
                                color: SUB_COLOR,
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
              ),
            );
          }, error: (error, stackTrace) {
            print("Error: $error alarmList");
            return SpinKitFadingCube(
              // FadingCube 모양 사용
              color: Colors.blue, // 색상 설정
              size: 50.0, // 크기 설정
              duration: Duration(seconds: 2), //속도 설정
            );
          }, loading: () {
            return SpinKitFadingCube(
              // FadingCube 모양 사용
              color: Colors.blue, // 색상 설정
              size: 50.0, // 크기 설정
              duration: Duration(seconds: 2), //속도 설정
            );
          }),
        ),
      ),
    );
  }
}
