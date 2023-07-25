import 'package:flutter/material.dart';

import '../../common/button/btn_toggle.dart';
import '../../common/const/colors.dart';

class AlarmList extends StatelessWidget {
  const AlarmList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: MAIN_COLOR,
          onPressed: (){},
      child: Icon(Icons.add,
      color: Colors.white,),),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Card(
          margin: const EdgeInsets.only(bottom: 600, right: 10, left: 10),
          child: InkWell(
            borderRadius: BorderRadius.circular(12.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                              '빨리 주말와라~~~',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),),
                      ),
                      BtnToggle(),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                          '12:00',
                      style:  TextStyle(
                        fontSize: 34.0,
                      ),),
                      SizedBox(
                        width: 150,
                      ),
                      Text(
                        'M T W T F S S',
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
}
