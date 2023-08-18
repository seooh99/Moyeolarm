import 'package:flutter/material.dart';
import 'package:moyeolam/common/const/colors.dart';
import 'package:moyeolam/user/model/user_model.dart';

class ProfileCard extends StatelessWidget {
  final Future? future;
  const ProfileCard({
    super.key,
    this.future,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(
          width: 2,
          color: MAIN_COLOR,
        ),
      ),
      color: BACKGROUND_COLOR,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: FutureBuilder(
              future: future,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return CircularProgressIndicator();
                }else if (snapshot.hasError) {
                  return CircleAvatar(
                    radius: 100,
                    backgroundColor: FONT_COLOR,
                  );
                } else if (snapshot.hasError) {
                  UserModel? userInfo = snapshot.data;
                  var profileImageUrl = userInfo!.profileImageUrl;
                  print("$profileImageUrl 123");
                  return SizedBox(
                    height: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: (profileImageUrl != null)?Image.network("$profileImageUrl", fit: BoxFit.fill,):Icon(Icons.person,size:30,color: FONT_COLOR,),
                    ),
                  );
                } else {
                  UserModel? userInfo = snapshot.data;
                  var profileImageUrl = userInfo!.profileImageUrl;
                  print("$profileImageUrl 123");
                  return SizedBox(
                    height: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: (profileImageUrl != null)?Image.network("$profileImageUrl", fit: BoxFit.fill,):Icon(Icons.person,size:30,color: FONT_COLOR,),
                    ),
                  );
                }
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: FutureBuilder(
                      future: future,
                      builder: (context, snapshot){
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('오류 발생: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          UserModel? userInfo = snapshot.data;
                          return Text(
                            '${userInfo?.nickname ?? '닉네임 없음'}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: FONT_COLOR,
                              fontSize: 24,
                            ),
                          );
                        } else {
                          return Text(
                            '닉네임 없음',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: FONT_COLOR,
                              fontSize: 24,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.drive_file_rename_outline,
                    size: 24,
                    color: FONT_COLOR,
                  ),
                ],
              ),
              // Divider(
              //   thickness: 2,
              //   color: MAIN_COLOR,
              // ),
                // SizedBox(
                //   height: 10,
                // ),
            ],
          )
        ],
      ),
    );
  }
}
