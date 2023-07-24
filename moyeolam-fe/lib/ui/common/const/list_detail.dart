import 'package:flutter/material.dart';


class ListDetail extends StatelessWidget {
  const ListDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const _ListDetail(),
    );
  }
}

class _ListDetail extends StatefulWidget {
  const _ListDetail({super.key});

  @override
  State<_ListDetail> createState() =>
      _ListDetailState();
}

class _ListDetailState extends State<_ListDetail> {

  bool _ischecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CheckboxListTile(
          title: Center(child: const Text('닉네임')),
          value: _ischecked,
          onChanged: (bool? value) {
            setState(() {
              _ischecked = value!;
            });
          },
          secondary: const Icon(Icons.people_alt_outlined),
        ),
      ),
    );
  }
}
