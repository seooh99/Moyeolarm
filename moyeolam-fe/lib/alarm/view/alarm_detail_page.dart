import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:youngjun/alarm/viewmodel/alarm_detail_view_model.dart';
import 'package:youngjun/common/button/btn_back.dart';

import '../../common/button/btn_save_update.dart';
import '../../common/clock.dart';
import '../../common/const/colors.dart';
import '../../common/layout/title_bar.dart';
import '../component/alarm_guest_list.dart';
import '../component/alarm_middle_select.dart';
import '../model/alarm_detail_model.dart';
import 'alarm_list_page.dart';

class AlarmDetailScreen extends StatefulWidget {
  final AlarmGroup alarmGroup;
  const AlarmDetailScreen({
    super.key,
  required this.alarmGroup
  });

  @override
  State<AlarmDetailScreen> createState() => _AlarmDetailScreenState();
}

class _AlarmDetailScreenState extends State<AlarmDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: BACKGROUND_COLOR,
      appBar: TitleBar(
        title: widget.alarmGroup.title,
      appBar: AppBar(),
      actions: [
        widget.alarmGroup.isHost?
                  BtnSaveUpdate(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              //수정페이지
                              "/");
                        },
                        text: "수정",
                      ):BtnSaveUpdate(
                        onPressed: () {
                          // Navigator.of(context).pushNamed(
                          //   //
                          //     "/"
                          // );
                          //  방나가기
                        },
                        text: "나가기",
                      ),
      ],
        leading: BtnBack(onPressed: (){
          Navigator.of(context).pop();
        }),
      ),
      body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  // Clock(timeSet: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, widget.alarmGroup.hour, widget.alarmGroup.minute)),

                  Container(
                    height: 120,
                    alignment: Alignment.center,
                    child: Text("${widget.alarmGroup.hour%12} : ${widget.alarmGroup.minute}   ${widget.alarmGroup.hour>=12?"PM":"AM"}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: FONT_COLOR,
                        fontSize: 40,

                      )),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  AlarmMiddleSelect(
                    dayOfWeek: widget.alarmGroup.dayOfWeek,
                    alarmSound: widget.alarmGroup.alarmMission,
                    alarmMission: widget.alarmGroup.alarmMission,
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
                  Container(
                    // color: Colors.white,
                    // alignment: Alignment.center,
                    width: 360,
                    height: 360,
                    child: GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: (150/92),
                      children: [
                        for(int index=0; index<widget.alarmGroup.members.length;index++)
                          AlarmGuestList(
                            nickname: widget.alarmGroup.members[index].nickname,
                            profileImage: Image.network("${widget.alarmGroup.members[index].profileUrl}")??Image.asset("assets/images/moyeolam"),
                          )
                        ,
                        SizedBox(
                          width: 10,
                          height: 10,
                          child: Container(
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                          height: 10,
                          child: Container(
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                          height: 10,
                          child: Container(
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                          height: 10,
                          child: Container(
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                          height: 10,
                          child: Container(
                            color: Colors.red,
                          ),
                        ),


                      ],
                    ),
                  )
                  // AlarmGuestList(
                  //   nickname: '성공할췅년!',
                  //   profileImage: Image.asset('assets/images/moyeolam.png'),
                  // ),
                ],
              ),
            ),
    );
  }
}





// class AlarmDetailScreen extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     var alarmGroup = ref.watch(alarmDetailProvider);
//     return alarmGroup.when(
//       data: (data) {
//         if (data != null) {
//           return Scaffold(
//             backgroundColor: BACKGROUND_COLOR,
//             appBar: TitleBar(
//               appBar: AppBar(),
//               title: data.title,
//               actions: [
//                 data.isHost
//                     ? BtnSaveUpdate(
//                         onPressed: () {
//                           Navigator.of(context).pushNamed(
//                               //수정페이지
//                               "/");
//                         },
//                         text: "수정",
//                       )
//                     : BtnSaveUpdate(
//                         onPressed: () {
//                           // Navigator.of(context).pushNamed(
//                           //   //
//                           //     "/"
//                           // );
//                           //  방나가기
//                         },
//                         text: "나가기",
//                       ),
//
//                 // TextButton(
//                 //   onPressed: () {
//                 //     Navigator.of(context).push(
//                 //         MaterialPageRoute(builder: (context) => MainAlarmList()));
//                 //   },
//                 //   child: Text(
//                 //     '수정하기',
//                 //     style: TextStyle(
//                 //       fontSize: 16,
//                 //     ),
//                 //   ),
//                 // )
//               ],
//               leading: BtnBack(onPressed: () {
//                 Navigator.of(context).pushNamed("/home");
//               }),
//             ),
//             body: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SizedBox(height: 20),
//                   // Clock(),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   // AlarmMiddleSelect(
//                   //   dayOfDay: '월, 수, 금',
//                   //   alarmSound: '희망',
//                   //   certification: '화상',
//                   // ),
//                   Text(
//                     '참여목록',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 18,
//                   ),
//                   AlarmGuestList(
//                     nickname: '성공할췅년!',
//                     profileImage: Image.asset('assets/images/moyeolam.png'),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         } else {
//           return Text(
//             "data is null",
//             textAlign: TextAlign.center,
//             style: TextStyle(color: FONT_COLOR),
//           );
//         }
//       },
//       error: (error, stackTrace) {
//         return Text("$error");
//       },
//       loading: () {
//         return SpinKitFadingCube(
//           // FadingCube 모양 사용
//           color: Colors.blue, // 색상 설정
//           size: 50.0, // 크기 설정
//           duration: Duration(seconds: 2), //속도 설정
//         );
//       },
//     );
//   }
// }
