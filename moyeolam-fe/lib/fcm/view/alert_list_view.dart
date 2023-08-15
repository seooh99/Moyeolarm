import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../common/layout/title_bar.dart';
import '../../common/secure_storage/secure_storage.dart';
import '../model/alert_service_model.dart';
import 'package:youngjun/common/const/colors.dart';
import '../service/alert_main_sevice.dart';
import 'alert_modal_view.dart';

// Dependency 주입을 위해 FlutterSecureStorage의 인스턴스가 필요합니다.
// 이를 Provider를 통해 제공받을 수 있습니다.
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return FlutterSecureStorage();
});

final userInformationProvider = Provider<UserInformation>((ref) {
  final storage = ref.read(secureStorageProvider);
  return UserInformation(storage);
});



class ListApp extends StatelessWidget {
  const ListApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ArletListView(),
    );
  }
}

class ArletListView extends ConsumerWidget {
  const ArletListView({Key? key}) : super(key: key);
  static const route = '/alerts';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alertService = ref.read(alertServiceProvider);
    final asyncAlertData = alertService.fetchData();
    final UserInformation _userInformation = ref.read(userInformationProvider);

    return Scaffold(
      appBar: TitleBar(
        appBar: AppBar(),
        title: ' 알림함',
        actions: [],
        leading: null,
      ),
      body: Container(
        color: LIST_BLACK_COLOR,
        padding: EdgeInsets.all(16),
        child: FutureBuilder<ApiArletModel?>(
          future: asyncAlertData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data!.data?.alerts != null && snapshot.data!.data!.alerts!.isNotEmpty) {
              final List<ApiArletItem> alertItems = snapshot.data!.data!.alerts!;

              return ListView.builder(
                itemCount: alertItems.length,
                itemBuilder: (context, index) {
                  final alertItem = alertItems[index];
                  final fromNickname = alertItem.fromNickname;
                  final alertType = alertItem.alertType;

                  return GestureDetector(
                    onTap: () {
                      if (fromNickname == null || alertType == null || alertItem.fromMemberId == null) return;
                      if (alertType == '친구 요청' || alertType == '알람그룹 요청') {
                        showPopup(
                          context,
                          fromNickname,
                          alertItem.title ?? "Default Title",
                          alertType,
                          alertItem.alarmGroupId,
                          alertItem.friendRequestId,
                          alertItem.fromMemberId,
                          _userInformation,
                        );
                      }
                    },
                    child: Card(
                      color: Colors.black,
                      child: Row(
                        children: [
                          SizedBox(width: 20, height: 80),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${fromNickname ?? "Unknown"} 님이 ${alertType ?? "알림"} 하셨습니다',
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: FONT_COLOR,
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasData && (snapshot.data!.data?.alerts?.isEmpty ?? true)) {
              return Center(child: Text('알림없음', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: FONT_COLOR)));
            } else {
              return Center(child: Text('Unexpected state', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: FONT_COLOR)));
            }
          },
        ),
      ),
    );
  }

  void showPopup(
      BuildContext context,
      String fromNickname,
      String title,
      String alertType,
      int? alarmGroupId,
      int? friendRequestId,
      int fromMemberId,
      UserInformation userInformation,
      ) {
    showDialog(
      context: context,
      builder: (context) {
        return APIDialog(
          fromNickname: fromNickname,
          titleList: title,
          alertTypeList: alertType,
          alarmGroupId: alarmGroupId,
          friendRequestId: friendRequestId,
          fromMemberId: fromMemberId,
          acceptOnPressed: () {},
          declineOnPressed: () {},
          userInformation: userInformation,
        );
      },
    );
  }
}
