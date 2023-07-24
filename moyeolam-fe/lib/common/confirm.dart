import 'package:flutter/material.dart';

/// Flutter code sample for [AlertDialog].

class Confirm extends StatefulWidget {
  Confirm({super.key});

  @override
  State<Confirm> createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> with RestorationMixin{
  late RestorableRouteFuture<String> _alertConfirmWithTitleRoute;

  @override
  String get restorationId => 'confirm';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore){
    registerForRestoration(
        _alertConfirmWithTitleRoute,
        'alert_confirm_with_title_route',
    );
  }

  void initState(){
    super.initState();
    _alertConfirmWithTitleRoute = RestorableRouteFuture<String>(
      onPresent: (navigator, arguments){
        return navigator.restorablePush(_alertConfirmWithTitleRoute);
      },
      onComplete: null,
    );
  }

  // String _title(BuildContext context){
  //   localizations.
  // }
  static Route<String> _alertConfirmWithTitleRouteDemo(
      BuildContext context,
      Object? arguments,
      ){
        final theme = Theme.of(context);
        final dialogTextStyle = theme.textTheme.titleMedium!.copyWith(color: theme.textTheme.bodySmall!.color);

        return DialogRoute<String>(context: context,
            builder: (context) {
          return ApllyTextOptions(
            title: Text("data"),
            content: Text("content"),
          ),
              actions
            })
  }
}


// class DialogExample extends StatelessWidget {
//   const DialogExample({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('알람 초대'),
//             content: const Text('OOOO님이 00:00분 알람에 초대하였습니다.'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () => Navigator.pop(context, 'Cancel'),
//                 child: const Text('취소'),
//               ),
//               TextButton(
//                 onPressed: () => Navigator.pop(context, '참여'),
//                 child: const Text('참여'),
//               ),
//             ],
//     );
    // return TextButton(
    //   onPressed: () => showDialog<String>(
    //     context: context,
    //     builder: (BuildContext context) => AlertDialog(
    //       title: const Text('알람 초대'),
    //       content: const Text('OOOO님이 00:00분 알람에 초대하였습니다.'),
    //       actions: <Widget>[
    //         TextButton(
    //           onPressed: () => Navigator.pop(context, 'Cancel'),
    //           child: const Text('취소'),
    //         ),
    //         TextButton(
    //           onPressed: () => Navigator.pop(context, '참여'),
    //           child: const Text('참여'),
    //         ),
    //       ],
    //     ),
    //   ),
    //   child: const Text('알람앱의 알람버튼 누르면 알람뜸'),
    // );
//   }
// }
