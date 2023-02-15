import 'package:flutter/material.dart';
import 'package:musikon_2022/blocs/player_singleton.dart';
import 'package:musikon_2022/objects.dart';
import 'package:musikon_2022/pages/song_menu.dart';
import 'package:musikon_2022/utils/utils.dart';
import '../widgets/row.dart';
import '../widgets/space.dart';

class CollectionPage extends StatelessWidget {
  final List<SongWrap> songs;
  final String title;
  final PlayerSingleton singleton;

  const CollectionPage({Key key, this.songs, this.title, this.singleton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 250.0,
              backgroundColor: Colors.transparent,
              pinned: true,
              floating: false,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold)),
                  background: ShaderMask(
                      shaderCallback: (rect) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Theme.of(context).scaffoldBackgroundColor,
                            Colors.transparent
                          ],
                        ).createShader(
                            Rect.fromLTRB(0, 0, rect.width, rect.height));
                      },
                      blendMode: BlendMode.dstIn,
                      child: Utils.getImage(
                          songs.first.songsId.album.cover.id,
                          MediaQuery.of(context).size.height * 0.2,
                          MediaQuery.of(context).size.height * 0.2))),
            ),
            // Loop through the songs and display them as RowSmall
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (context, index) {
                return RowSmall(
                  song: songs[index].songsId,
                  onTap: () {
                    singleton.playSong(songs[index].songsId);
                  },
                  onLongPress: () {
                    showDialog(
                      context: context,
                      barrierColor:
                      Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
                      builder: (BuildContext context) => Menu(
                        song: songs[index].songsId,
                        playSong: () {
                          singleton.playSong(songs[index].songsId);
                          Navigator.of(context).pop();
                        },
                      ),
                    );
                  },
                );
              },
              childCount: songs.length,
            )),
            const SpaceWidget()
          ],
        ));
  }
}
