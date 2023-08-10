import 'package:flutter/material.dart';
import 'package:youngjun/alarm/viewmodel/add_alarm_group_view_model.dart';
import 'package:youngjun/common/const/colors.dart';

class AlarmMiddleSelect extends StatefulWidget {
  static List<String> week = ["월 ", "화 ", "수 ", "목 ", "금 ", "토 ", "일 "];

  AlarmMiddleSelect({
    // required this.dayOfWeek,
    // required this.alarmSound,
    // required this.alarmMission,
    required this.addAlarmGroupViewModel,
    super.key
  });
  final AddAlarmGroupViewModel addAlarmGroupViewModel;
  // final List<bool> dayOfWeek;
  // final String alarmSound;
  // final String alarmMission;

  @override
  State<AlarmMiddleSelect> createState() => _AlarmMiddleSelectState();
}

class _AlarmMiddleSelectState extends State<AlarmMiddleSelect> {
  // final AddAlarmGroupViewModel _addAlarmGroupViewModel = AddAlarmGroupViewModel();

  // var dayOfDay = dayOfWeek[];
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            const SizedBox(height: 18,),
            GestureDetector(
              onTap: (){
                dialogList(context,"기본 알림음");
                setState(() {

                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 60,
                  ),
                  Text(
                    '알림음',
                    style: TextStyle(
                      color: FONT_COLOR,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    width: 152,
                  ),
                  Row(
                    children: [
                      Text(
                        widget.addAlarmGroupViewModel.alarmSound,
                        style: TextStyle(
                          color: FONT_COLOR,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 12,),
                      Icon(
                          Icons.arrow_right_sharp,
                          color: FONT_COLOR,
                        ),

                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18,),
            GestureDetector(
              onTap: (){
                dialogList(context,"얼굴 인식");
                setState(() {

                });
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 60,
                  ),
                  const Text(
                    '인증방식',
                    style: TextStyle(
                      color: FONT_COLOR,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 136,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.addAlarmGroupViewModel.alarmMission,
                        style: const TextStyle(
                          color: FONT_COLOR,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      const Icon(
                          Icons.arrow_right_sharp,
                          color: FONT_COLOR,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18,),

                const SizedBox(
                  width: 60,
                ),
                const Text(
                  '반복 요일',
                  style: TextStyle(
                    color: FONT_COLOR,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 10),
                  for (int index=0;index<7;index++)
                    GestureDetector(
                      onTap: (){
                        widget.addAlarmGroupViewModel.setDayOfWeek(index);
                        setState(() {

                        });
                      },
                      child: Text(AlarmMiddleSelect.week[index],
                          style: TextStyle(
                            color: widget.addAlarmGroupViewModel.dayOfWeek[index]?MAIN_COLOR:FONT_COLOR,
                            fontSize: 24,
                          ),
                        ),

                    ),
                  const SizedBox(width: 10),
                ],
              ),
            const SizedBox(height: 18,),
          ],
        ),
      );
  }
}

dialogList(
    BuildContext context,
    String name,
    // Function(String) onTap
    ){
  return showDialog(
    context: context,
    barrierDismissible: true,
      builder: (context) {
        final itemCount = 1; // 리스트 항목 수
        const listItemHeight = 50.0; // 각 항목의 높이
        final dialogHeight = itemCount * listItemHeight;

        return Dialog(
        backgroundColor: BACKGROUND_COLOR,
          child: Container(
          height: dialogHeight,
            child: Scrollbar(
              child: ListView.builder(
                itemCount: itemCount,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      // onTap("");
                      Navigator.pop(context);
                    },
                    style: ListTileStyle.list,
                  // height: listItemHeight,
                  // color: [BACKGROUND_COLOR, LIST_BLACK_COLOR][index % 2],
                    title: Text(
                      name,
                      style: TextStyle(
                          fontSize: 24,
                          color: FONT_COLOR
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    }
  );
}