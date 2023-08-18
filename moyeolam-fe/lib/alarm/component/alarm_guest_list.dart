import 'package:flutter/material.dart';

import '../../common/const/colors.dart';

class AlarmGuestList extends StatefulWidget {
  const AlarmGuestList({
    required this.color,
    required this.nickname,
    this.profileImageUrl,
    super.key});

  final String? profileImageUrl;
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
                      child: (widget.profileImageUrl != null)?Image.network("${widget.profileImageUrl}"):Icon(Icons.person,size:30,),
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
