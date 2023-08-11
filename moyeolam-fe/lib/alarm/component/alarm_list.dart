import 'package:flutter/material.dart';

import '../../common/button/btn_toggle.dart';
import '../../common/const/colors.dart';

List<String> week = ["M", "T", "W", "T", "F", "S", "S"];

class AlarmList extends StatelessWidget {

  const AlarmList({super.key,

    required this.alarmGroupId,
    required this.weekday,
    required this.hour,
    required this.minute,
    required this.toggle,
    required this.title,
  });
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
              margin: const EdgeInsets.only(right: 10, left: 10),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        BtnToggle(
                          value: toggle,
                          onChanged: (bool value) {},
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          hour.toString().length == 1 && minute.toString().length == 2?
                          '0$hour : $minute':
                          hour.toString().length == 2 && minute.toString().length == 1?
                          '$hour : 0$minute':
                          hour.toString().length == 1 && minute.toString().length == 1?
                          '0$hour : 0$minute':
                          '$hour : $minute',
                          style: TextStyle(
                            fontSize: 34.0,
                          ),
                        ),
                        SizedBox(
                          width: 150,
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
                                    fontSize:12,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              )
                          ],
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
