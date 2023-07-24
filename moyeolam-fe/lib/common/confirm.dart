import 'package:flutter/material.dart';

class Confirm extends StatefulWidget {
  const Confirm({super.key});

  @override
  State<Confirm> createState() => _Confirm();
}

class _Confirm extends State<Confirm> {
  var isClicked = false;

  @override
  Widget build(BuildContext context){
    return TextButton(
        onPressed: () => showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: const Text("title"),
                content: const Text("content"),
                actions: <Widget>[
                  TextButton(
                      onPressed: () => Navigator.pop(context, "Cancel"),
                      child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, "Ok"),
                    child: const Text("Ok"),
                  ),
                ],
              );
            },
        ),
        child: const Text("button"),
    );
  }
}

