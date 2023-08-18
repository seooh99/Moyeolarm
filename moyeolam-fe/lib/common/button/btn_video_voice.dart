import 'package:flutter/material.dart';

import '../const/colors.dart';

class BtnMedia extends StatelessWidget {
  final Icon icons;
  final VoidCallback? onPressed;
  const BtnMedia({
    super.key,
    required this.icons,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

    final ButtonStyle style =
    ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(10),
      backgroundColor: BACKGROUND_COLOR,
    );

    return ElevatedButton(
          style: style,
          onPressed: onPressed,
          child: icons,
        );
  }
}

