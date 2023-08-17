import 'package:flutter/material.dart';
import 'package:youngjun/alarm/viewmodel/add_alarm_group_view_model.dart';
import 'package:youngjun/common/const/colors.dart';

class AlarmMiddleSelect extends StatefulWidget {
  static List<Widget> week = [
    Text("월"),
    Text("화"),
    Text("수"),
    Text("목"),
    Text("금"),
    Text("토"),
    Text("일"),
    ];

  AlarmMiddleSelect({
    this.dayOfWeek,
    this.alarmSound,
    this.alarmMission,
    required this.addAlarmGroupViewModel,
    super.key
  });
  final AddAlarmGroupViewModel addAlarmGroupViewModel;
  final List<bool>? dayOfWeek;
  final String? alarmSound;
  final String? alarmMission;

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
                // print(widget.dayOfWeek);
                dialogList(context,"기본 알림음");
                setState(() {

                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left:40),
                      child: Text(
                        '알림음',
                        style: TextStyle(
                          color: FONT_COLOR,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: 120,
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Row(
                      children: [
                        Text(
                          widget.alarmSound??widget.addAlarmGroupViewModel.alarmSound,
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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: const Text(
                        '인증방식',
                        style: TextStyle(
                          color: FONT_COLOR,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   width: 136,
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.alarmMission??widget.addAlarmGroupViewModel.alarmMission,
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
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18,),


                Center(
                  child: const Text(
                    '반복 요일',
                    style: TextStyle(
                      color: FONT_COLOR,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const SizedBox(width: 10),
                    ToggleButtons(
                      borderColor: Colors.grey,
                      borderRadius: BorderRadius.circular(50),
                      selectedBorderColor: MAIN_COLOR,
                      selectedColor: MAIN_COLOR,
                      color: FONT_COLOR,
                      onPressed: (index){
                        widget.addAlarmGroupViewModel.setDayOfWeek(index);
                        setState(() {
                          if(widget.dayOfWeek != null) {
                            widget.dayOfWeek![index] = !widget.dayOfWeek![index];
                          }
                        });
                      },
                        isSelected:
                        widget.dayOfWeek ?? widget.addAlarmGroupViewModel.dayOfWeek,
                        children: AlarmMiddleSelect.week,
                      textStyle: TextStyle(
                        fontSize: 20,
                      ),

                    )
                  // const SizedBox(width: 10),
                ],
              ),
            const SizedBox(height: 18,),
          ],
        ),
      );
  }
}

// TextButton(
// style: TextButton.styleFrom(
// textStyle: TextStyle(
// color: (widget.dayOfWeek!= null ?
// widget.dayOfWeek![index]:
// widget.addAlarmGroupViewModel.dayOfWeek[index])?MAIN_COLOR:FONT_COLOR,
// fontSize: 20,
// ),
// ),
// onPressed: (){
// widget.addAlarmGroupViewModel.setDayOfWeek(index);
// setState(() {});
// },
// child: Text(AlarmMiddleSelect.week[index]
// ),
// ),

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