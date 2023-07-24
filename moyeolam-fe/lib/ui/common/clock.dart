import 'package:flutter/material.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  var _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TimePicker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Future<TimeOfDay?> selectedTime = showTimePicker(
                    context:
                    context, // context 는 Future 타입으로 TimeOfDay 타입의 값을 반환 합니다
                    initialTime: TimeOfDay.now(), // 프로퍼티에 초깃값을 지정합니다.
                  );
                  selectedTime.then((value) {
                    setState(() {
                      _selectedTime = '${value?.hour} : ${value?.minute}';
                    });
                  });
                },
                child: Text('Time Picker'),
              ),
              Text('$_selectedTime'),
            ],
          ),
        ),
      ),
    );
  }
}