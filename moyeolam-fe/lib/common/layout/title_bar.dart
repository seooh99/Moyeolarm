import 'package:flutter/material.dart';
import 'package:moyeolam/common/const/colors.dart';

class TitleBar extends StatelessWidget implements PreferredSizeWidget {
  const TitleBar({
    super.key,

    required this.appBar,
    required this.title,
    this.actions,
    this.leading,
  });

  final AppBar appBar;
  final String title;
  final List<Widget>? actions;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: BACKGROUND_COLOR,
      title: Text(title, style:
        TextStyle(color: FONT_COLOR),),
      actions: actions,
      leading: leading,
      // actions: [
      //
      //   IconButton(
      //       icon: Icon(titleIcon),
      //       color: MAIN_COLOR,
      //       onPressed: () {
      //         print("Pressed!");
      //         onPressed();
      //       }),
      // ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
