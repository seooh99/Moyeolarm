import 'package:flutter/material.dart';

class ElevatedButtonExample extends StatefulWidget {
  const ElevatedButtonExample({super.key});

  @override
  State<ElevatedButtonExample> createState() => _ElevatedButtonExampleState();
}

class _ElevatedButtonExampleState extends State<ElevatedButtonExample> {
  @override
  Widget build(BuildContext context) {

    final ButtonStyle style =
    ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
        minimumSize: Size(220, 40),
        primary: Colors.red);

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
