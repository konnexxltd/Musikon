import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musikon_2022/blocs/player_singleton.dart';
import 'package:musikon_2022/pages/collection_page.dart';
import 'package:musikon_2022/pages/no_connection_page.dart';
import 'package:musikon_2022/utils/repository.dart';
import 'package:musikon_2022/utils/transition.dart';
import 'package:musikon_2022/widgets/empty_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:uuid/uuid.dart';

import '../objects.dart';
import '../pages/loading_page.dart';
import '../pages/song_menu.dart';
import '../widgets/row.dart';
import '../widgets/row_large.dart';
import '../widgets/title.dart';
import '../widgets/upbutton.dart';
import 'const.dart';

class Utils {
  static configureApp() async {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
    ));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  static saveRefreshToken(String refreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('refreshToken', refreshToken);
  }

  static getRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('refreshToken');
  }

  static clearRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('refreshToken');
  }

  static getImage(String id, num height, num width) {
    return CachedNetworkImage(
      imageUrl: Repository.url + '/assets/' + id,
      height: height,
      fadeInDuration: const Duration(milliseconds: 500),
      width: width,
      fit: BoxFit.cover,
      placeholder: (context, string) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.20,
          width: MediaQuery.of(context).size.width * 0.35,
          color: Theme.of(context).scaffoldBackgroundColor,
        );
      },
      httpHeaders: {'Authorization': 'Bearer ${Repository.accessToken}'},
    );
  }

  static generateUUID() {
    var uuid = const Uuid();
    return uuid.v4();
  }

  static handleSnapshot(
      {@required Function ui,
      VoidCallback onError,
      @required BuildContext context,
      @required AsyncSnapshot snapshot,
      String title,
      ScrollController controller}) {
    Widget child = const LoadingPage();

    if (snapshot.hasData) {
      if (snapshot.data.isLoading) {
        child = const LoadingPage();
      } else {
        child = ui(snapshot.data);
      }
    }

    if (onError != null) {
      if (snapshot.hasError) {
        child = NoConnectionPage(
          onPressed: () {
            onError();
          },
        );
      }
    }

    return Scaffold(
      appBar: title != null
          ? CupertinoNavigationBar(
              middle: Text(
                title,
                style: Theme.of(context).textTheme.headline6,
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              border: null,
              trailing: controller != null ? UpButton(controller) : null,
            )
          : null,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: Constant.load),
        child: child,
      ),
    );
  }

  static parseRow(
      {String title,
      String subtitle,
      String collectionId,
      List<SongWrap> songs,
      String display,
      BuildContext context,
      PlayerSingleton singleton,
      String id}) {
    List<Widget> slivers = [];

    if (title != null || subtitle != null || collectionId != null) {
      Widget header = TitleWidget(
        title: title,
        subtitle: subtitle,
        onTap: songs.isNotEmpty
            ? () {
                Navigator.of(context, rootNavigator: true)
                    .push(createRoute(CollectionPage(
                  title: title,
                  songs: songs,
                  singleton: singleton,
                )));
              }
            : null,
      );

      slivers.add(SliverToBoxAdapter(
        child: header,
      ));
    }

    if (!songs.isNotEmpty) {
      slivers.add(EmptyState(
        title: Constant.strings["no_songs_found_state"],
      ));
    }

    if (display == Constant.displayLarge && songs.isNotEmpty) {
      slivers.add(SliverToBoxAdapter(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.27,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            itemBuilder: (songsContext, index) {
              return RowLarge(
                song: songs[index].songsId,
                onTap: () {
                  singleton.playSong(songs[index].songsId);
                  log(id);
                },
                onLongPress: () {
                  showDialog(
                    context: context,
                    barrierColor: Theme.of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(0.9),
                    builder: (BuildContext context) => Menu(
                      song: songs[index].songsId,
                      playSong: () {
                        singleton.playSong(songs[index].songsId);
                        Navigator.of(context).pop();
                      },
                      addToFavourites: () {},
                    ),
                  );
                },
              );
            },
            itemCount: songs.length,
          ),
        ),
      ));
    }

    if (display == Constant.displaySmall && songs.isNotEmpty) {
      slivers.add(SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
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
                addToFavourites: () {},
              ),
            );
          },
        );
      }, childCount: songs.length)));
    }

    return MultiSliver(children: slivers);
  }
}
