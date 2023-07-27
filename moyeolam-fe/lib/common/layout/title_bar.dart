import 'package:flutter/material.dart';
import 'package:youngjun/common/const/colors.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: BACKGROUND_COLOR,
      title: const Text("모여람"),
      actions: [
        IconButton(
            icon: Icon(Icons.notifications), onPressed: () => onPressed()),
      ],
    );
  }
}
