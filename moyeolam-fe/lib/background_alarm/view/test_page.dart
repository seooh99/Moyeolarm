import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

AudioPlayer player = AudioPlayer();

Future audioPlayer() async {
  await player.setVolume(75);
  await player.setSpeed(1);
  await player.setAsset('assets/audio/sound.mp3');
  player.play();
}

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    audioPlayer();

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: ElevatedButton(
          child: const Text("새로운 페이지입니다."),
          onPressed: () {},
        ),
      ),
    );
  }
}
