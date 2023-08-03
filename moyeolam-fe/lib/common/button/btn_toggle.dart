import 'package:flutter/material.dart';

class BtnToggle extends StatefulWidget {

  final bool value;
  final ValueChanged<bool> onChanged;

  const BtnToggle({Key? key, required this.value, required this.onChanged}) : super(key: key);

  @override
  State<BtnToggle> createState() => _BtnToggleState();
}

class _BtnToggleState extends State<BtnToggle> {
  bool light = true;

  @override
  void initState() {
    super.initState();
    light = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: light,
      activeColor: Colors.deepPurple,
      onChanged: (bool value) {
        widget.onChanged(value);
        setState(() {
          light = value;
        });
      },
    );
  }
}