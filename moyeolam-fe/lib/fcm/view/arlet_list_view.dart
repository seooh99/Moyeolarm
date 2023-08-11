import 'package:flutter/material.dart';

import '../../common/confirm.dart';
import '../../common/layout/title_bar.dart';

import 'package:dio/dio.dart';

import '../api/arlet_modal_api.dart';
import '../api/strategies/friend_accept_strategy.dart';
import '../model/arlet_service_model.dart';
import '../service/fcm_api_service.dart';
import 'package:youngjun/common/const/colors.dart';
import 'dart:convert';

import 'arlet_modal_view.dart'; // import this

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

class ArletListView extends StatefulWidget {
  const ArletListView({Key? key}) : super(key: key);
  static const route = '/alerts';

  @override
  State<ArletListView> createState() => _ArletListViewState();
}

class _ArletListViewState extends State<ArletListView> {
  final dio = Dio();
  final fcmapiService = FcmApiService(Dio());

  ApiArletModel? alertData; // 단일 객체로 변경

  @override
  void initState() {
    super.initState();
    fetchData(); // API 요청 함수 호출
  }

  Future<void> fetchData() async {
    try {
      final response = await fcmapiService.getPosts();
      print('API 응답 데이터: $response');

      if (response != null) {
        final ApiArletModel alert = response; // response를 그대로 할당
        setState(() {
          alertData = alert; // 리스트에 하나의 alert 추가
          print('데이터 가져오는 중...');
        });
      } else {
        print('null값임!');
        // 응답이 null인 경우 "알림없음"을 화면에 출력
        setState(() {
          alertData = ApiArletModel(); // alertData를 비우고
        });
      }
    } on DioError catch (e) {
      print('DioError 발생: $e');
    } catch (e) {
      print('기타 에러 발생~~~: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
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
        child: _buildAlertList(),
      ),
    );
  }

  Widget _buildAlertList() {
    if (alertData?.data?.alerts != null) {
      final List<ApiArletItem> alertItems = alertData!.data!.alerts!;

      return ListView.builder(
        itemCount: alertItems.length,
        itemBuilder: (context, index) {
          final ApiArletItem alertItem = alertItems[index];
          final String? fromNickname = alertItem.fromNickname;
          final String? alertType = alertItem.alertType;

          return GestureDetector(
            onTap: () {
              if (fromNickname == null || alertType == null || alertItem.fromMemberId == null) {
                return;
              }
              if (alertType ==  '친구 요청' ||
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

          // ... rest of the GestureDetector code ...

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
                          '${fromNickname ?? "Unknown"} 님이 ${alertType ??
                              "알림"} 하셨습니다',
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
              fontSize: 16, fontWeight: FontWeight.bold, color: FONT_COLOR),
        ),
      );
    }
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





