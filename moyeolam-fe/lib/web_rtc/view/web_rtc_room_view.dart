import 'package:flutter/material.dart';
import 'package:youngjun/common/button/btn_call.dart';
import 'package:youngjun/common/button/btn_video_voice.dart';
import 'package:youngjun/common/const/colors.dart';


class WebRtcRoomView extends StatefulWidget {
  const WebRtcRoomView({super.key});

  @override
  State<WebRtcRoomView> createState() => _WebRtcRoomViewState();
}

class _WebRtcRoomViewState extends State<WebRtcRoomView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: BACKGROUND_COLOR,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                height: 180,
                width: 172,
                decoration: const BoxDecoration(
                  color: MAIN_COLOR,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30)
                  )
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                height: 180,
                width: 172,
                decoration: const BoxDecoration(
                    color: MAIN_COLOR,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(
                        Radius.circular(30)
                    )
                ),
              ),
            ],
          ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  height: 180,
                  width: 172,
                  decoration: const BoxDecoration(
                      color: MAIN_COLOR,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                          Radius.circular(30)
                      )
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  height: 180,
                  width: 172,
                  decoration: const BoxDecoration(
                      color: MAIN_COLOR,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                          Radius.circular(30)
                      )
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  height: 180,
                  width: 172,
                  decoration: const BoxDecoration(
                      color: MAIN_COLOR,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                          Radius.circular(30)
                      )
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  height: 180,
                  width: 172,
                  decoration: const BoxDecoration(
                      color: MAIN_COLOR,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                          Radius.circular(30)
                      )
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            ElevatedButton(
              onPressed: (){},
              child: Text("비상탈출"),
            ),
            Row(
              children:[
                BtnMedia(
                  icons: Icon(Icons.mic, color: FONT_COLOR),
                  // icons: Icon(Icons.mic_off),
                  onPressed: (){},
                ),
                BtnCalling(
                icons: Icon(Icons.call_end),
                backGroundColor: CALLOFF_COLOR,
                onPressed: (){},
              ),
                BtnMedia(
                  icons: Icon(Icons.videocam, color: FONT_COLOR,),
                  // icons: Icon(Icons.videocam_off),
                  onPressed: (){},
                ),
      ]
            ),
            SizedBox(
              height: 20,
            )

          ],
        ),
      ),
    );
  }
}
