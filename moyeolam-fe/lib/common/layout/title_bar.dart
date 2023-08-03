import 'package:flutter/material.dart';
import 'package:youngjun/common/const/colors.dart';

class TitleBar extends StatelessWidget implements PreferredSizeWidget {
  const TitleBar({
    super.key,
    required this.onPressed,
    this.titleIcon,
    required this.appBar,
    required this.title,
    this.testBtn,
  });

  final VoidCallback onPressed;
  final IconData? titleIcon;
  final AppBar appBar;
  final String title;
  final String? testBtn;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      centerTitle: true,
      backgroundColor: BACKGROUND_COLOR,
      title: Text(title,
      style: TextStyle(
        color: Colors.white,
      ),),
      actions: [

        testBtn == null ? IconButton(
              icon: Icon(titleIcon),
              color: MAIN_COLOR,
              onPressed: () {
                print("Pressed!");
                onPressed();
              }) : TextButton(
          onPressed: onPressed,
          child: Text(testBtn!),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
