import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:moyeolam/background_alarm/provider/permission_provider.dart';
import 'package:moyeolam/main.dart';

class PermissionRequestScreen extends ConsumerStatefulWidget {
  const PermissionRequestScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PermissionRequestScreen();
}
class _PermissionRequestScreen extends ConsumerState<PermissionRequestScreen>{

  @override
  void initState() {
    // TODO: implement initState

    ref.read(permissionProvider).isGrantedAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var permission = ref.watch(permissionProvider);
    if (permission.isGranted) {
        return widget.child;
      }
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('알람 작동을 위한 권한을 허용해주세요.'),
              TextButton(
                onPressed: permission.requestSystemAlertWindow,
                child: const Text('설정하기'),
              ),
            ],
          ),
        ),
      );
    }
    // var futurePermission = ref.watch(permissionFutureProvider);
    // if (permission.isGranted) {
    //   setState(() {
    //
    //   });
    //     return widget.child;
    //   }


}


// @override
// Widget build(BuildContext context) {
//   return Consumer<PermissionProvider>(
//     builder: (context, provider, _) {
//       if (provider.isGrantedAll()) {
//         return child;
//       }
//       return Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text('알람 작동을 위한 권한을 허용해주세요.'),
//               TextButton(
//                 onPressed: provider.requestSystemAlertWindow,
//                 child: const Text('설정하기'),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }


//return futurePermission.when(
//         data: (data){
//             print("${permission.isGranted} if문 밖");
//           if(permission.isGranted ){
//             print("${permission.isGranted}1211");
//             return widget.child;
//           }else{
//             return Scaffold(
//               body: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text('알람 작동을 위한 권한을 허용해주세요.'),
//                     TextButton(
//                       onPressed:() {
//                         permission.requestSystemAlertWindow;
//
//                       },
//                       child: const Text('설정하기'),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }
//         },
//         error: (error, stackTrace){
//           return Text("error..");
//         },
//         loading: (){
//           return Text("loding..");
//         },
//     );