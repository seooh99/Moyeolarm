import 'package:flutter/material.dart';


class BtnSaveUpdate extends StatelessWidget {
  const BtnSaveUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(
                  fontSize: 18,

              ),
            ),
            onPressed: () {},
            child: const Text('저장',
              style: TextStyle(
                  fontSize: 18,
                  color:Colors.purple,
                ),
              ),




    );
  }
}
