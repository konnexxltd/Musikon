import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../objects.dart';
import '../utils/const.dart';
import '../utils/utils.dart';

class Menu extends StatelessWidget {
  final Song song;
  final VoidCallback playSong, addToFavourites, removeFromFavourites;

  const Menu({
    Key key,
    this.song,
    this.playSong,
    this.addToFavourites,
    this.removeFromFavourites,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverList(
                  delegate: SliverChildListDelegate.fixed([
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                )
              ])),
              SliverList(
                delegate: SliverChildListDelegate.fixed([
                  Utils.getImage(
                      song.album.cover.id,
                      MediaQuery.of(context).size.height * 0.4,
                      MediaQuery.of(context).size.height * 0.4),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text(
                    song.name,
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    song.userCreated.firstName +
                        " " +
                        song.userCreated.lastName,
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.center,
                  ),
                  makeListItem(Icons.play_arrow, 'Play Song', () async {
                    playSong();
                  }, context),
                  // makeListItem(Icons.favorite, 'Add to Favourite', () async {
                  //   addToFavourites();
                  // }, context),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  makeListItem(IconData iconData, String text, VoidCallback onTap,
      BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            highlightColor: Theme.of(context).scaffoldBackgroundColor,
            child: SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    text,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const Spacer(),
                  Icon(
                    iconData,
                    size: 30,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            onTap: onTap,
          ),
        )
      ],
    );
  }
}
