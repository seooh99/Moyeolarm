import 'package:flutter/material.dart';

import 'package:youngjun/ui/common/const/list_total.dart';

void main(){
  runApp(
    _Moyuram(),
  );
}

class _Moyuram extends StatelessWidget {
  const _Moyuram({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: ListTotal(),
        )
    );
  }
}
