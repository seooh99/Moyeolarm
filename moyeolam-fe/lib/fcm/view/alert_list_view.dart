import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moyeolam/common/button/btn_back.dart';
import 'package:moyeolam/common/layout/title_bar.dart';
import 'package:moyeolam/fcm/service/alert_main_sevice.dart';
import '../../common/secure_storage/secure_storage.dart';
import '../model/alert_service_model.dart';
import 'package:moyeolam/common/const/colors.dart';
import 'alert_modal_view.dart';


abstract class ListApp extends ConsumerStatefulWidget {
  const ListApp({Key? key}) : super(key: key);

  @override
  _ListAppState createState() => _ListAppState();
}

class _ListAppState extends ConsumerState<ListApp> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(alertServiceProvider);
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ArletListView(),
    );
  }
}

class ArletListView extends ConsumerWidget {
  const ArletListView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiAlertModelAsyncValue = ref.watch(alertServiceProvider);

    return Scaffold(
      appBar: TitleBar(
        appBar: AppBar(),
        title: "모여람",
        leading: BtnBack(
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        actions: [

        ],
      ),
      backgroundColor: BACKGROUND_COLOR,
      body: Padding(
        padding: EdgeInsets.all(12),
        child: apiAlertModelAsyncValue.when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text("데이터 로딩 실패: $err")),
          data: (apiAlertModel) {
            return RefreshIndicator(
              onRefresh: ()async{
                ref.invalidate(alertServiceProvider);
              },
                child: _buildAlertList(apiAlertModel, ref)
            );
          },
        ),
      ),

    );
  }


  Widget _buildAlertList(ApiArletModel apiAlertModel, WidgetRef ref) {
    if (apiAlertModel.data?.alerts != null && apiAlertModel.data!.alerts!.isNotEmpty) {
      final List<ApiArletItem?> alertItems = apiAlertModel.data!.alerts!;
      return ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: alertItems.length,
        itemBuilder: (context, index) => _buildAlertItem(context, alertItems[index], ref),
      );
    } else {
      return const SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
          child: Center(
              child: Text('알림없음',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight:FontWeight.bold,
                      color: FONT_COLOR
                  )
              )
          )
      );
    }
  }

  Widget _buildAlertItem(BuildContext context, ApiArletItem? alertItem, WidgetRef ref) {
    final fromNickname = alertItem!.fromNickname;
    final alertType = alertItem!.alertType;

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
            alertItem.fromMemberId!,
            ref
          );
        }
      },
      child: Card(
        color: (alertType == '친구 요청' || alertType == '알람그룹 요청')
            ? SUB_COLOR
            : BACKGROUND_COLOR,
        elevation: 12,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: (alertType == '친구 요청' || alertType == '알람그룹 요청')
                ? SUB_COLOR
                : BACKGROUND_COLOR,
            width: 2,
          )
        ),
        child: Container(
          // color:
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 20, height: 80),
              Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${fromNickname ?? "Unknown"} 님이 ${alertType ?? "알림"} 하셨습니다',
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: (alertType == '친구 요청' || alertType == '알람그룹 요청')
                            ? BACKGROUND_COLOR
                            : FONT_COLOR,
                      ),
                    ),
                    // const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
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
      WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return APIDialog(
          fromNickname: fromNickname,
          titleList: title,
          alertTypeList: alertType,
          alarmGroupId: alarmGroupId,
          friendRequestId: friendRequestId,
          fromMemberId: fromMemberId,
          acceptOnPressed: () {},
          declineOnPressed: () {},
          onDialogHandled: () => ref.invalidate(alertServiceProvider),
        );
      },
    );
  }
}