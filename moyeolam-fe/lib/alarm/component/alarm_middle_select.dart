import 'package:flutter/material.dart';

class AlarmMiddleSelect extends StatelessWidget {
  const AlarmMiddleSelect(
      {required this.dayOfDay,
      required this.alarmSound,
      required this.certification,
      super.key});

  final String dayOfDay;
  final String alarmSound;
  final String certification;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '반복 요일',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Row(
                children: [
                  Text(
                    '월,수,금',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '알림음',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Row(
                children: [
                  Text(
                    '희망♬',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '인증방식',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Row(
                children: [
                  Text(
                    '화상',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
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
