import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moyeolam/main.dart';


PermissionProvider instancPermissionProvider = PermissionProvider(storage);

final permissionProvider = ChangeNotifierProvider((ref){
  return instancPermissionProvider;
});

// final permissionFutureProvider = FutureProvider((ref) {
//    return instancPermissionProvider.isGrantedAll();
// });

class PermissionProvider extends ChangeNotifier {
  PermissionProvider(this.storage);


  // SharedPreferences _preferences;

  @visibleForTesting
  static const String systemAlertWindowGranted = "systemAlertWindowGranted";

  FlutterSecureStorage storage;
  late bool isGranted;

  Future<void> isGrantedAll() async {
    var data = await storage.read(key: systemAlertWindowGranted);
    if (data != null){
      print("data");
      isGranted = (data == "true")?true:false;
    }else{
      print("data null");
      isGranted = false;
    }
    notifyListeners();
  }

  // bool isGrantedAll() {
  //   return _preferences.getBool(systemAlertWindowGranted) ?? false;
  // }

  Future<void> requestSystemAlertWindow() async {
    if (await Permission.systemAlertWindow.status != PermissionStatus.granted) {
      await Permission.systemAlertWindow.request();
    }


    if (await Permission.systemAlertWindow.status == PermissionStatus.granted){
      await storage.write(key: systemAlertWindowGranted, value: "true");
      isGranted = true;
    }
    // if (await Permission.systemAlertWindow.status == PermissionStatus.granted) {
    //   await _preferences.setBool(systemAlertWindowGranted, true);
    //   return true;
    // }
    notifyListeners();
  }
}
