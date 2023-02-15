import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:musikon_2022/objects.dart';

import 'package:musikon_2022/widgets/panel/panel_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../utils/const.dart';
import '../../utils/utils.dart';

class MusicPanel extends StatefulWidget {
  const MusicPanel({Key key}) : super(key: key);

  @override
  _MusicPanelState createState() => _MusicPanelState();
}

class _MusicPanelState extends State<MusicPanel> {
  PanelBloc panelBloc = PanelBloc();

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    EdgeInsets padding = EdgeInsets.only(bottom: 50.0 + bottomPadding);
    log("Panel Built");

    return Padding(
        padding: padding,
        child: StreamBuilder(
          stream: panelBloc.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return getSlidingPanel(context, snapshot.data);
            }
            return Container();
          },
        ));
  }

  loadCollapsed({BuildContext context, PanelBlocObject object}) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          makeWaves(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child:
                        Utils.getImage(object.song.album.cover.id, 40.0, 40.0),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        object.song.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            color: Theme.of(context).textTheme.headline6.color),
                      ),
                      InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          // createRoute(
                          //     ArtistPage(song.userId, song.username)));
                        },
                        child: Text(
                          object.song.userCreated.firstName +
                              " " +
                              object.song.userCreated.lastName,
                          style: TextStyle(
                              color: CupertinoColors.systemGrey,
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.025),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  makePlayBtn(object.state),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  getSlidingPanel(BuildContext context, PanelBlocObject object) {
    return SlidingUpPanel(
        color: Theme.of(context).scaffoldBackgroundColor,
        isDraggable: false,
        minHeight: MediaQuery.of(context).size.height * 0.080,
        borderRadius: BorderRadius.zero,
        panel: Container(color: Colors.black,),
        collapsed: loadCollapsed(context: context, object: object));
  }

  makePlayBtn(String state) {
    return IconButton(
      key: UniqueKey(),
      icon: Icon(
        state == Constant.playing ? Icons.pause : Icons.play_arrow,
        // playerProvider.playing ? Icons.pause : Icons.play_arrow,
      ),
      color: Colors.white,
      splashColor: Theme.of(context).scaffoldBackgroundColor,
      highlightColor: Theme.of(context).scaffoldBackgroundColor,
      onPressed: () {
        if (state == Constant.paused) {
          panelBloc.playerSingleton.changeState(Constant.playing);
        } else {
          panelBloc.playerSingleton.changeState(Constant.paused);

        }
        // Player.resumeOrPause();
      },
    );
  }

  makeWaves() {
    return Container();

  }

  makeNextBtn() {
    return IconButton(
      key: UniqueKey(),
      splashColor: Theme.of(context).scaffoldBackgroundColor,
      highlightColor: Theme.of(context).scaffoldBackgroundColor,
      color: Colors.white,
      icon: const Icon(Icons.skip_next),
      onPressed: () async {},
    );
  }

  makeBackBtn() {
    return IconButton(
      key: UniqueKey(),
      splashColor: Theme.of(context).scaffoldBackgroundColor,
      highlightColor: Theme.of(context).scaffoldBackgroundColor,
      color: Colors.white,
      icon: const Icon(Icons.skip_previous),
      onPressed: () {},
    );
  }
}
