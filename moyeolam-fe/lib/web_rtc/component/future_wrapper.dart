import 'package:flutter/material.dart';
import 'package:moyeolam/common/const/colors.dart';

class FutureWrapper extends StatefulWidget {
  final Future future;
  final Widget Function(BuildContext context) builder;

  const FutureWrapper({
    Key? key,
    required this.future,
    required this.builder,
  }) : super(key: key);

  @override
  State<FutureWrapper> createState() => _FutureWrapperState();
}

class _FutureWrapperState extends State<FutureWrapper> {
  late Future future;

  @override
  void initState() {
    future = widget.future;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Container(
            color: BACKGROUND_COLOR,
            // child: const LoadingWidget(),
          );
        } else {
          return widget.builder(context);
        }
      },
    );
  }
}
