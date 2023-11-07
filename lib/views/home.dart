import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_app/constants/constants.dart';
import 'package:music_player_app/controllers/player_controller.dart';
import 'package:music_player_app/views/palayer_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerAudioController());
    return Scaffold(
      backgroundColor: Color(0xff1d1d1d),
      appBar: AppBar(
        centerTitle: true,
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: Colors.white),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Beats",
          style: style,
        ),
      ),
      body: FutureBuilder<List<SongModel>>(
        future: controller.onAudioQuery.querySongs(
          ignoreCase: true,
          orderType: OrderType.ASC_OR_SMALLER,
          sortType: null,
          uriType: UriType.EXTERNAL,
        ),
        builder: (contex, snapShot) {
          if (snapShot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapShot.data!.isEmpty) {
            return Center(
              child: Text(
                "No Songs Are Founded ",
                style: style,
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(8),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapShot.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Obx(
                      () => ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        tileColor: Color(0xff232D3F),
                        title: Text(
                          "${snapShot.data![index].displayNameWOExt}",
                          style: style.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          "${snapShot.data![index].artist}",
                          style: style.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        leading: QueryArtworkWidget(
                          id: snapShot.data![index].id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: Icon(
                            Icons.music_note,
                          ),
                          artworkFit: BoxFit.cover,
                        ),
                        trailing: controller.playerIndex.value == index &&
                                controller.isplay.value
                            ? Icon(
                                Icons.play_arrow_rounded,
                              )
                            : null,
                        onTap: () {
                          controller.playSong(
                            snapShot.data![index].uri,
                            index,
                          );

                          Get.to(
                            () => PlayeAudioScreen(
                              songs: snapShot.data![index],
                            ),
                            transition: Transition.leftToRight,
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
