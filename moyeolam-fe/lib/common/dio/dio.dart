import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:youngjun/common/const/data.dart';
import 'package:youngjun/common/secure_storage/secure_storage.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();

  final storage = ref.watch(secureStorageProvider);

  dio.interceptors.add(
      CustomInterceptor(storage: storage)
  );

  return dio;
});

class CustomInterceptor extends Interceptor {

  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage;
  });

  @override
  void onRequest(RequestOptions options,
      RequestInterceptorHandler handler) async {

    print('[REQ] [${options.method}] ${options.uri}');

    if(options.headers['accessToken'] == 'true'){

      options.headers.remove('accessToken');

      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      options.headers.addAll({
        'authorization' :'Bearer $token',
      });
    }

    if(options.headers['refreshToken'] == 'true'){

      options.headers.remove('refreshToken');

      final token =await storage.read(key: REFRESH_TOKEN_KEY);

      options.headers.addAll({
        'authorization' : 'Bearer $token',
      });

    }

    return super.onRequest(options, handler);
  }

@override
  void onResponse(Response response, ResponseInterceptorHandler handler) {

    print('[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');

    return super.onResponse(response, handler);
  }


  // @@@ 백엔드 uri 주소보고 밑에 작성하기~!

  // @override
  // void onError(DioException err, ErrorInterceptorHandler handler) async {
  //
  //   print('[REQ] [${err.requestOptions.method}] ${err.requestOptions.uri}');
  //
  //   final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
  //
  //   if(refreshToken == null){
  //     return handler.reject(err);
  //   }
  //
  //   final isStatus401 = err.response?.statusCode == 401;
  //
  //   // @@@@@@@@@ 밑에 토큰 받는 url 쓰기 (ex) '/auth/token'
  //   // final isPathRefresh = err.requestOptions.path == ''
  //
  //   if(isStat)
  //
  //   return super.onError(err, handler);
  // }

}