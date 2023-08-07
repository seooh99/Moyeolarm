import 'package:flutter/material.dart';

import '../../common/const/colors.dart';

class AlarmGuestList extends StatefulWidget {
  const AlarmGuestList({
    required this.nickname,
    required this.profileImage,
    super.key});

  final Image profileImage;
  final String nickname;

  @override
  State<AlarmGuestList> createState() => _AlarmGuestListState();
}

class _AlarmGuestListState extends State<AlarmGuestList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: 100,
          width: 160,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
              side: BorderSide(
                width: 3,
                color: MAIN_COLOR,
              ),
            ),
            color: BACKGROUND_COLOR,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.deepOrange,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  '성공할 청년',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 100,
          width: 160,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
              side: BorderSide(
                width: 3,
                color: Colors.white,
              ),
            ),
            color: BACKGROUND_COLOR,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.yellow,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'SUCCESS BOY',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}