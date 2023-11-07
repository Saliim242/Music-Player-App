import 'dart:developer';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerAudioController extends GetxController {
  final onAudioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();

  var playerIndex = 0.obs;
  var isplay = false.obs;

  playSong(String? uri, index) {
    playerIndex.value = index;
    try {
      audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(uri!),
        ),
      );

      audioPlayer.play();
      isplay(true);
    } on Exception catch (e) {
      log(e.toString(), name: "Playing Audio");
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkPermession();
  }

  checkPermession() async {
    var status = await Permission.storage.request();

    if (status.isGranted) {
    } else {
      checkPermession();
    }
  }
}
