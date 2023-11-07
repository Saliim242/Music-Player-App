import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_app/constants/constants.dart';
import 'package:music_player_app/controllers/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayeAudioScreen extends StatelessWidget {
  final SongModel songs;
  const PlayeAudioScreen({
    super.key,
    required this.songs,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerAudioController>();
    return Scaffold(
      backgroundColor: Color(0xff1e1e1e),
      appBar: AppBar(
        backgroundColor: Color(0xff2d2e2d),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: 300,
                width: 300,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: QueryArtworkWidget(
                  id: songs.id,
                  type: ArtworkType.AUDIO,
                  artworkHeight: MediaQuery.of(context).size.height,
                  artworkWidth: MediaQuery.of(context).size.width,
                  artworkFit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(
                      16,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      "${songs.displayNameWOExt}",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "${songs.artist}",
                      style: style.copyWith(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          "00:00",
                          style: style.copyWith(
                            color: Colors.blueAccent,
                          ),
                        ),
                        Expanded(
                          child: Slider(
                            inactiveColor: Colors.lightBlue,
                            value: 0.0,
                            onChanged: (newValue) {},
                          ),
                        ),
                        Text(
                          "04:00",
                          style: style.copyWith(
                            color: Colors.blueAccent,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.skip_previous_rounded,
                            size: 40,
                          ),
                        ),
                        Obx(
                          () => CircleAvatar(
                            backgroundColor: Color(0xff1e1e1e),
                            radius: 25,
                            child: Transform.scale(
                              scale: 2,
                              child: IconButton(
                                onPressed: () {
                                  if (controller.isplay.value) {
                                    controller.audioPlayer.pause();
                                    controller.isplay(false);
                                  } else {
                                    controller.audioPlayer.play();
                                    controller.isplay(true);
                                  }
                                },
                                icon: controller.isplay.value
                                    ? Icon(
                                        Icons.pause_outlined,
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.skip_next_rounded,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
