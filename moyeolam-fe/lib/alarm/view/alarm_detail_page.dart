import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/alarm/model/alarm_detail_model.dart';
import 'package:youngjun/alarm/provider/alarm_detail_provider.dart';

import '../../common/clock.dart';
import '../../common/const/colors.dart';
import '../../common/layout/title_bar.dart';
import '../component/alarm_guest_list.dart';
import '../component/alarm_middle_select.dart';
import 'alarm_list_page.dart';

class AlarmDetailScreen extends ConsumerWidget {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<AlarmGroup?> alarmGroupDetail = ref.watch(alarmGroupDetailProvider);

    return Scaffold(
        backgroundColor: BACKGROUND_COLOR,
        appBar: TitleBar(
          appBar: AppBar(),
          title: alarmGroupDetail.when(
              data: (alarmGroup) => alarmGroup?.title ?? 'None',
              loading: () => 'Loading...',
              error: (error, stackTrace) => 'Error'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MainAlarmList()));
              },
              child: Text(
                '수정',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            )
          ],
          leading: null,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Clock(
                timeSet: DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day, 10, 11),
              ),
              SizedBox(
                height: 20,
              ),
              AlarmMiddleSelect(
                dayOfDay: alarmGroupDetail.when(
                    data: (alarmGroup) => "월, 화, 수" ?? "None",
                    loading: () => "None",
                    error: (error, stackTrace) => "None"),
                alarmSound: alarmGroupDetail.when(
                    data: (alarmGroup) => alarmGroup?.alarmSound ?? 'None',
                    loading: () => 'Loading...',
                    error: (error, stackTrace) => 'Error'),
                alarmMission: alarmGroupDetail.when(
                    data: (alarmGroup) => alarmGroup?.alarmMission ?? 'None',
                    loading: () => 'Loading...',
                    error: (error, stackTrace) => 'Error'),
              ),
              Text(
                '참여목록',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 18,
              ),
              // Container(
              //   child: alarmGroupDetail.when(
              //       data: (alarmGroup) {
              //         if (alarmGroup != null) {
              //           return ListView.builder(
              //             itemCount: alarmGroup.members?.length,
              //             itemBuilder: (context, index) {
              //               Member member = alarmGroup.members![index];
              //               return AlarmGuestList(
              //                 nickname: member.nickname!,
              //                 profileImage: Image.asset("assets/images/moyeolam.png"),
              //
              //               );
              //             },
              //           );
              //         }
              //       },
              //       error: (error, stackTrace) {},
              //       loading: () {}),
              // )
            ],
          ),
        ));
  }
}
