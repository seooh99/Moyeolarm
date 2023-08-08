import 'package:flutter/material.dart';

import '../../common/layout/title_bar.dart';

import 'package:dio/dio.dart';

import '../service/fcm_api_service.dart';
import 'package:youngjun/common/const/colors.dart';

// void main() async {
//   final dio = Dio(); // Dio 인스턴스 생성
//   final fcmapiService = FcmApiService(dio);
//
//   try {
//     final alerts = await fcmapiService.getPosts(); // API로부터 데이터 가져오기
//     // alerts 리스트는 API에서 받아온 알림 데이터의 리스트입니다.
//
//     for (var alert in alerts) {
//       print('${alert.fromNickname} 님이 ${alert.alertType} 하셨습니다');
//     }
//   } catch (e) {
//     print('에러입니다: $e');
//   }
// }




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
  const ArletListView({super.key});
  static const route = '/arlet-screen';

  @override
  State<ArletListView> createState() => _ArletListViewState();
}

class _ArletListViewState extends State<ArletListView> {
  final dio = Dio();
  final fcmapiService = FcmApiService(Dio());

  var fromNickname = [];
  var titleList = [];
  var alertTypeList = [];

  @override
  void initState() {
    super.initState();
    fetchData(); // API 요청 함수 호출
  }

  // API 요청을 처리하고 데이터를 할당하는 함수
  Future<void> fetchData() async {


    try {
      final alerts = await fcmapiService.getPosts(); // API로부터 데이터 가져오기

      setState(() {
        // 받아온 데이터를 변수에 할당
        fromNickname = alerts.map((alert) => alert.fromNickname).toList();
        titleList = alerts.map((alert) => alert.title).toList();
        alertTypeList = alerts.map((alert) => alert.alertType).toList();
      });
    } catch (e) {
      print('에러입니다: $e');
    }
  }


  void showPopup(context, fromNickname, titleList, alertTypeList) {
    showDialog(context: context, builder: (context) {
      return Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width*0.7 ,
          height: 380,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Text(fromNickname, style: TextStyle(
                  fontSize: 20,
                ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                alertTypeList,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(padding: EdgeInsets.all(8),
                child: Text(
                  titleList,
                  maxLines: 6,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }






  @override
  Widget build(BuildContext context) {

    final message = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(

      appBar: TitleBar(
        appBar: AppBar(),
        title: ' 알림함',
        actions: [],
        leading: null,),
      body: Container(
        color: LIST_BLACK_COLOR,
        padding: EdgeInsets.all(16), // 간격 조정
        child: ListView.builder(
          itemCount: titleList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                debugPrint(alertTypeList[index]);
                showPopup(context, fromNickname[index], titleList[index], alertTypeList[index]);
              },
              child: Card(
                color: Colors.black,

                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 80,


                    ),
                    Padding(padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text('${fromNickname[index]} 님이 ${alertTypeList[index]} 하셨습니다',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        )
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