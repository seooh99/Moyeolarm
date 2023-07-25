import 'package:flutter/material.dart';

class BtnVoice extends StatefulWidget {
  const BtnVoice({super.key});

  @override
  State<BtnVoice> createState() => _BtnVoice();
}

class _BtnVoice extends State<BtnVoice> {
  @override
  Widget build(BuildContext context) {

    final ButtonStyle style =
    ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(10),
        primary: Colors.white);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          style: style,
          onPressed: () {},
          child: Icon(Icons.voice_over_off,
            color: Colors.black,),
        ),
      ),
    );
  }
}
