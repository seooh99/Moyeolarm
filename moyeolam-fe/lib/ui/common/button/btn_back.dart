import 'package:flutter/material.dart';

/// Flutter code sample for [IconButton].


class BtnBack extends StatelessWidget {
  const BtnBack({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(4.0),
      child: ButtonTypesGroup(enabled: true),
    );
  }
}

class ButtonTypesGroup extends StatelessWidget {
  const ButtonTypesGroup({super.key, required this.enabled});

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final VoidCallback? onPressed = enabled ? () {} : null;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
              icon: const Icon(Icons.arrow_back_ios_new), onPressed: onPressed),
          ]
      ),
    );
  }
}
