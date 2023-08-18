import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;
import 'package:moyeolam/user/view/auth.dart';

import 'package:kakao_flutter_sdk_auth/kakao_flutter_sdk_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



class GlobalVariable {
  static final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();
}

final FlutterSecureStorage storage = FlutterSecureStorage();

void main() async {
  await dotenv.load(fileName: 'assets/config/.env');
  String nativeKey = dotenv.get("KAKAO_NATIVE_KEY");
  KakaoSdk.init(nativeAppKey: nativeKey);


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(child: _Moyuram()),
  );

  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };
}

class _Moyuram extends StatelessWidget {
  const _Moyuram({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // storage.deleteAll();
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ko', 'KR'),
      ],
      locale: Locale('ko'),
      home: AuthView(),

    );
  }
}
