import 'package:flutter/material.dart';

class BtnToggle extends StatefulWidget {
  const BtnToggle({super.key});

  @override
  State<BtnToggle> createState() => _BtnToggleState();
}

class _BtnToggleState extends State<BtnToggle> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Switch(
      // This bool value toggles the switch.
      value: light,
      activeColor: Colors.deepPurple,
      onChanged: (bool value) {
        // This is called when the user toggles the switch.
        setState(() {
          light = value;
        });
      },
    );
  }
}
