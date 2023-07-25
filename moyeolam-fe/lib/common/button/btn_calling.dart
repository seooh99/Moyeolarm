import 'package:flutter/material.dart';

class BtnCalling extends StatefulWidget {
  const BtnCalling({super.key});

  @override
  State<BtnCalling> createState() => _BtnCalling();
}

class _BtnCalling extends State<BtnCalling> {
  @override
  Widget build(BuildContext context) {

    final ButtonStyle style =
    ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
        minimumSize: Size(280, 40),
        primary: Colors.purple);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          style: style,
          onPressed: () {},
          child: Icon(Icons.call),
        ),
      ),
    );
  }
}
