import 'package:flutter/material.dart';

import '../../common/layout/title_bar.dart';

import 'package:dio/dio.dart';

import '../model/arlet_service_model.dart';
import '../service/fcm_api_service.dart';
import 'package:youngjun/common/const/colors.dart';
import 'dart:convert'; // import this

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
      // 데이터를 가져오는 부분에서 ApiArletModel으로 받아오고, 그 안에 있는 ApiArletData를 사용하는 예시
      if (response != null) {
        if (response is ApiArletModel) {
          print('API 응답 데이터는 ApiArletModel 타입입니다.');
          setState(() {
            alertData = response;
          });
        } else {
          print('API 응답 데이터가 ApiArletModel 타입이 아닙니다.');
        }
      } else {
        print('response가 null입니다.');
        setState(() {
          alertData = null;
        });
      }
    } on DioError catch (e) {
      print('DioError 발생: $e');
    } catch (e) {
      print('기타 에러 발생~~~: $e');
    }
  }


  void showPopup(context, fromNickname, titleList, alertTypeList) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width * 0.7,
            height: 380,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Text(
                    fromNickname ?? "알림없음",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  alertTypeList ?? "알림없음",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    titleList ?? "알림없음",
                    maxLines: 6,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
              if (fromNickname == null || alertType == null) {
                return;
              }

              debugPrint(alertType);
              showPopup(
                context,
                fromNickname,
                alertItem.title,
                alertType,
              );
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
                          '${fromNickname ?? "Unknown"} 님이 ${alertType ??
                              "알림"} 하셨습니다',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      );
    }
  }
}