import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/layout/title_bar.dart';

import 'package:dio/dio.dart';


import '../model/alert_service_model.dart';
import '../data_source/fcm_api_data_source.dart';
import 'package:youngjun/common/const/colors.dart';


import '../provider/alert_privider.dart';
import '../service/alert_main_sevice.dart';
import 'alert_modal_view.dart'; // import this




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
  static const route = '/alerts'; // Define the route here

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // AlertService 인스턴스를 가져옴
    final alertService = ref.read(alertServiceProvider);
    final asyncAlertData = alertService.fetchData();

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
              print("Data is Loading");
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              print("Error occurred: ${snapshot.error}");
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData && snapshot.data!.data?.alerts != null) {
              print("Data received");
              final List<ApiArletItem> alertItems = snapshot.data!.data!.alerts!;

              return ListView.builder(
                itemCount: alertItems.length,
                itemBuilder: (context, index) {
                  final ApiArletItem alertItem = alertItems[index];
                  final String? fromNickname = alertItem.fromNickname;
                  final String? alertType = alertItem.alertType;

                  return GestureDetector(
                    onTap: () {
                      if (fromNickname == null ||
                          alertType == null ||
                          alertItem.fromMemberId == null) {
                        return;
                      }
                      if (alertType == '친구 요청' ||
                          alertType == '알람그룹 요청') {
                        debugPrint(alertType);
                        showPopup(
                          context,
                          fromNickname,
                          alertItem.title ?? "Default Title",
                          alertType,
                          alertItem.alarmGroupId,
                          alertItem.friendRequestId,
                          alertItem.fromMemberId,
                        );
                      }
                    },
                    child: Card(
                      color: Colors.black,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                            height: 80,
                          ),
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
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text(
                  '알림없음',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: FONT_COLOR,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

void showPopup(
    BuildContext context,
    String fromNickname,
    String title,
    String alertType,
    int? alarmGroupId,
    int? friendRequestId,
    int fromMemberId,
    ) {
  showDialog(
    context: context,
    builder: (context) {
      return APIDialog(
        fromNickname: fromNickname,
        titleList: title,
        alertTypeList: alertType,
        alarmGroupId: alarmGroupId, // 그대로 int 값 전달
        friendRequestId: friendRequestId, // 그대로 int 값 전달
        fromMemberId: fromMemberId,
        acceptOnPressed: () {
        },
        declineOnPressed: () {

        },

      );
    },
  );
}





