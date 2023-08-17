import 'package:flutter/material.dart';
import 'package:moyeolam/alarm/viewmodel/alarm_list_view_model.dart';

import '../../common/button/btn_toggle.dart';
import '../../common/const/colors.dart';

List<String> week = ["M", "T", "W", "T", "F", "S", "S"];

class AlarmList extends StatelessWidget {

  AlarmList({super.key,
    this.toggleChanged,
    required this.alarmGroupId,
    required this.weekday,
    required this.hour,
    required this.minute,
    required this.toggle,
    required this.title,
  });
  final AlarmListViewModel _alarmListViewModel = AlarmListViewModel();
  final ValueChanged<bool>? toggleChanged;
  final int alarmGroupId;
  final List<bool> weekday;
  final int hour;
  final int minute;
  final bool toggle;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Card(
            // color: FONT_COLOR.withOpacity(.85),
            // color: Colors.white10,
            color: CARD_BACK_GROUND_COLOR,

              margin: const EdgeInsets.only(right: 10, left: 10),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: MAIN_COLOR,
                  )),
              child: Padding(
                // padding: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.only(bottom: 28.0, left: 16, right: 16, top: 12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: FONT_COLOR,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        BtnToggle(
                          value: toggle,
                          onChanged: (value) async{
                            if(toggleChanged != null) {
                              toggleChanged!(value);
                            }
                          },
                        ),
                        SizedBox(
                          width: 12,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                        width: 20,
                      ),
                        Expanded(
                          child: Text(
                            hour.toString().length == 1 && minute.toString().length == 2?
                            '0$hour : $minute':
                            hour.toString().length == 2 && minute.toString().length == 1?
                            '$hour : 0$minute':
                            hour.toString().length == 1 && minute.toString().length == 1?
                            '0$hour : 0$minute':
                            '$hour : $minute',
                            style: TextStyle(
                              color: FONT_COLOR,
                              fontSize: 40.0,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            for(int index = 0;index < 7; index ++)

                              Padding(
                                padding: const EdgeInsets.only(left: 2,right: 2),
                                child: Text(
                                  week[index],
                                  style: TextStyle(
                                      color: weekday[index]?MAIN_COLOR:Colors.grey,
                                    fontSize:16,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              )
                          ],
                        ),
                        SizedBox(
                          width: 12,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ),
        // Padding(
        //     padding: EdgeInsets.symmetric(vertical: 10),
        //     child: Card(
        //         shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(10),
        //             side: BorderSide(
        //               color: MAIN_COLOR,
        //               width: 2,
        //             )),
        //         child: Padding(
        //           padding: const EdgeInsets.symmetric(vertical: 40),
        //           child: Center(
        //             child: Icon(
        //               Icons.add,
        //               color: MAIN_COLOR,
        //             ),
        //           ),
        //         )
        //     )
        // ),
      ],
    );
  }
}
