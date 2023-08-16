import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/fcm/repository/alert_list_repository.dart';

// class AlertListViewModel {
//   final _alertListRepository = AlertListRepository();
//
//   getAlarmList() async {
//     var response = await _alertListRepository.getAlertList();
//     if (response.code == "200") {
//       return response.data;
//     }
//   }
//
//
//   final alertProvider = FutureProvider.autoDispose((ref) async {
//     final viewModel = AlertListViewModel();
//     return await viewModel.getAlarmList();
//   });
// }