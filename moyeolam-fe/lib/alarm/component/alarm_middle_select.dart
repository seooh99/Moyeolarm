import 'package:flutter/material.dart';
import 'package:youngjun/common/const/colors.dart';

class AlarmMiddleSelect extends StatelessWidget {
static List<String> week = ["월 ", "화 ", "수 ", "목 ", "금 ", "토 ", "일 "];
  const AlarmMiddleSelect(
      {required this.dayOfWeek,
      required this.alarmSound,
      required this.alarmMission,
      super.key});

  final List<bool> dayOfWeek;
  final String alarmSound;
  final String alarmMission;



  // var dayOfDay = dayOfWeek[];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [

          SizedBox(height: 18,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 60,
              ),
              Text(
                '알림음',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                width: 152,
              ),
              Row(
                children: [
                  Text(
                    alarmSound,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(width: 12,),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_right_sharp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 18,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 60,
              ),
              Text(
                '인증방식',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                width: 136,
              ),
              Row(
                children: [
                  Text(
                    alarmMission,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_right_sharp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 18,),
          Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 60,
              ),
              Text(
                '반복 요일',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                width: 54,
              ),
              Row(

                children: [
                  Row(
                    children: [
                      for (int index=0;index<7;index++)
                        Text(week[index],
                          style: TextStyle(
                            color: dayOfWeek[index]?MAIN_COLOR:Colors.white,
                            fontSize: 18,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_right_sharp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        SizedBox(height: 18,),
        ],
      ),
    );
  }
}
