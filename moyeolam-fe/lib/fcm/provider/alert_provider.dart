import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../common/secure_storage/secure_storage.dart';
import '../../user/model/user_model.dart';
import '../model/alert_service_model.dart';
import '../repository/alert_list_repository.dart';
import '../service/alert_main_sevice.dart';
import '../viewmodel/alert_list_view_model.dart';

// alertModelProvider: ApiArletModel을 가져오기 위한 FutureProvider.
// 이 프로바이더는 데이터를 가져오기 위해 AlertService의 fetchData 메서드를 호출합니다.
//
// alertServiceProvider: AlertService 인스턴스를 제공하는 Provider.
//
// secureStorageProvider: FlutterSecureStorage 인스턴스를 제공하는 Provider.
//
// userInformationProvider: UserInformation 인스턴스를 가져오는 FutureProvider.

final alertModelProvider = FutureProvider.autoDispose<ApiArletModel>((ref) async {
  final alertService = ref.read(alertServiceProvider);
  return await alertService.fetchData();
});


// final alertProvider = FutureProvider.autoDispose((ref) async {
//   final viewModel = AlertListViewModel();
//   return await viewModel.getAlarmList();
// });


final alertServiceProvider = Provider<AlertService>((ref) {
  final userInformationAsyncValue = ref.watch(userInformationProvider);

  if (userInformationAsyncValue is AsyncData<UserInformation>) {
    return AlertService(userInformationAsyncValue);
  }

  // 로딩 상태나 에러 상태에 대한 처리는 여기서 추가로 해주셔야 합니다.
  throw Exception('로드안됨');
});


final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return FlutterSecureStorage();
});

final userInformationProvider = Provider<UserInformation>((ref) {
  final storage = ref.read(secureStorageProvider);
  return UserInformation(storage);
});

final userInfoProvider = FutureProvider<UserModel?>((ref) async {
  final userInformation = ref.read(userInformationProvider);
  return await userInformation.getUserInfo();
});
