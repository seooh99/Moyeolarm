import 'package:flutter/material.dart';

import '../../common/layout/title_bar.dart';

import 'package:dio/dio.dart';

import '../model/arlet_service_model.dart';
import '../service/fcm_api_service.dart';
import 'package:youngjun/common/const/colors.dart';

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

  List<ApiArletModel> alertData = []; // 변경된 데이터 타입

  @override
  void initState() {
    super.initState();
    fetchData(); // API 요청 함수 호출
  }

  // API 요청을 처리하고 데이터를 할당하는 함수
  Future<void> fetchData() async {
    try {
      final response = await fcmapiService.getPosts(); // List<ApiArletModel> 형식의 데이터 가져오기
      print('API 응답: $response'); // 응답 데이터 출력
      final alerts = response; // 실제 데이터 추출
      setState(() {
        alertData = alerts; // 그대로 할당
        print('Fetching data...');
      });
    } catch (e) {
      print('에러입니다 여기에요!! 여기로 들어와요!!: $e');
    }
  }

  void showPopup(context, fromNickname, titleList, alertTypeList) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
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
        child: ListView.builder(
          itemCount: alertData.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (alertData.isEmpty) {
                  return;
                }
                debugPrint(alertData[index].alertType);
                showPopup(
                  context,
                  alertData[index].fromNickname,
                  alertData[index].title,
                  alertData[index].alertType,
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
                            '${alertData[index].fromNickname} 님이 ${alertData[index].alertType} 하셨습니다',
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
        ),
      ),
    );
  }
}
