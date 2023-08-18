import 'package:flutter/material.dart';

import '../../common/const/colors.dart';

class AlarmGuestList extends StatefulWidget {
  const AlarmGuestList({
    required this.color,
    required this.nickname,
    this.profileImage,
    super.key});

  final String? profileImage;
  final String nickname;
  final Color color;
  // final bool

  @override
  State<AlarmGuestList> createState() => _AlarmGuestListState();
}

class _AlarmGuestListState extends State<AlarmGuestList> {
  @override
  Widget build(BuildContext context) {


    return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: BorderSide(
                  width: 3,
                  color: widget.color,
                ),
              ),
              color: BACKGROUND_COLOR,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(
                    height: 40,
                    width: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: (widget.nickname == "서희") ?Image.asset("assets/images/Limseohee.jpg"):Image.asset("assets/images/seongku.png"),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    widget.nickname,
                    style: TextStyle(
                        color: FONT_COLOR,
                    ),
                  )
                ],
              ),
    );
  }
}
