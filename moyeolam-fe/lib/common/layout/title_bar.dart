import 'package:flutter/material.dart';
import 'package:youngjun/common/const/colors.dart';

class TitleBar extends StatelessWidget implements PreferredSizeWidget {
  const TitleBar({
    super.key,
    required this.onPressed,
    this.titleIcon,
    required this.appBar,
    required this.title,
  });
  final VoidCallback onPressed;
  final IconData? titleIcon;
  final AppBar appBar;
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: BACKGROUND_COLOR,
      title: title,
      actions: [
        IconButton(
            icon: Icon(titleIcon),
            onPressed: () {
              print("Pressed!");
              onPressed();
            }),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
