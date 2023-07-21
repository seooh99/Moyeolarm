import 'package:flutter/material.dart';

/// Flutter code sample for [TextButton].

void main() => runApp(const TextButtonExampleApp());

class TextButtonExampleApp extends StatelessWidget {
  const TextButtonExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('TextButton Sample')),
        body: const TextButtonExample(),
      ),
    );
  }
}

class TextButtonExample extends StatelessWidget {
  const TextButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          const SizedBox(height: 35),
          TextButton(
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
            ),



        ],
      ),
    );
  }
}
