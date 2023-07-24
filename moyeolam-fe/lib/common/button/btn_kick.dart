import 'package:flutter/material.dart';


class BtnKick extends StatefulWidget {
  const BtnKick({super.key});

  @override
  State<BtnKick> createState() => _IconButtonExampleState();
}

class _IconButtonExampleState extends State<BtnKick> {
  @override
  Widget build(BuildContext context) {
    return
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {},
        );

  }
}
