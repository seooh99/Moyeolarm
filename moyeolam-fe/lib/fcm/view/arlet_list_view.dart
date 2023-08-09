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

  Future<void> fetchData() async {
    try {
      final response = await fcmapiService.getPosts();
      print('API 응답 데이터: $response');

      if (response != null) {
        final ApiArletModel alert = response; // response를 그대로 할당
        setState(() {
          alertData = [alert]; // 리스트에 하나의 alert 추가
          print('데이터 가져오는 중...');
        });
      } else {
        print('null값임!');
        // 응답이 null인 경우 "알림없음"을 화면에 출력
        setState(() {
          alertData = []; // alertData를 비우고
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
