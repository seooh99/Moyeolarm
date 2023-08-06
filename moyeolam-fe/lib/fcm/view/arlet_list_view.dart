import 'package:flutter/material.dart';

import '../../common/layout/title_bar.dart';



class ListApp extends StatelessWidget {
  const ListApp({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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

  var fromNickname = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
  ];
  var titleList = [
    '1번입니다',
    '2번입니다',
    '3번입니다',
    '4번입니다',
    '5번입니다',
    '6번입니다',
    '1번입니다',
    '2번입니다',
    '3번입니다',
    '4번입니다',
    '5번입니다',
    '6번입니다',

  ];
  var alertTypeList = [
    "친구 수락",
    "친구 요청",
    "알람그룹 수락",
    "알람그룹 탈퇴",
    "알람그룹 강퇴",
    "알람그룹 요청",
    "친구 수락",
    "친구 요청",
    "알람그룹 수락",
    "알람그룹 탈퇴",
    "알람그룹 강퇴",
    "알람그룹 요청",
  ];


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
                  fontSize: 25,
                ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                alertTypeList,
                style: const TextStyle(
                  fontSize: 20,
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
        onPressed: () {  },
        titleIcon: null,
        appBar: AppBar(),
        title: '',
        actions: [],),
      body: ListView.builder(
        itemCount: titleList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              debugPrint(alertTypeList[index]);
              showPopup(context, fromNickname[index], titleList[index], alertTypeList[index]);
            },
            child: Card(
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                  ),
                  Padding(padding: EdgeInsets.all(10),
                      child: Column(
                        children: [Text(alertTypeList[index],
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),
                        ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 360,
                            child: Text(
                                titleList[index],
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey
                                )),
                          )
                        ],
                      )
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}