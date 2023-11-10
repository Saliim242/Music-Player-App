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

  var duration = ''.obs;
  var position = ''.obs;

  var max = 0.0.obs;
  var value = 0.0.obs;

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
      updatePositionAndDuration();
    } on Exception catch (e) {
      log(e.toString(), name: "Playing Audio");
    }
  }

  // Update Position and Duration

  updatePositionAndDuration() {
    audioPlayer.durationStream.listen((d) {
      duration.value = d.toString().split('.')[0];
      max.value = d!.inSeconds.toDouble();
    });

    audioPlayer.positionStream.listen((p) {
      position.value = p.toString().split('.')[0];
      value.value = p.inSeconds.toDouble();
    });
  }

  // Change The Slider Of The Sick

  changeSliderDuration(seconds) {
    var duration = Duration(seconds: seconds);

    audioPlayer.seek(duration);
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
