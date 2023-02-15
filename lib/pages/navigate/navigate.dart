import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musikon_2022/pages/collection/collection.dart';
import 'package:musikon_2022/pages/explore/explore.dart';
import 'package:musikon_2022/pages/navigate/navigate_bloc.dart';
import 'package:musikon_2022/pages/search/search.dart';
import 'package:musikon_2022/utils/const.dart';
import 'package:musikon_2022/utils/utils.dart';

import '../../widgets/panel/panel.dart';
import '../settings/settings.dart';

class Navigate extends StatefulWidget {
  const Navigate({Key key}) : super(key: key);

  @override
  _NavigateState createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> {
  NavigateBloc bloc = NavigateBloc();
  MusicPanel panel;


  @override
  initState() {
    panel = const MusicPanel();
    super.initState();
  }


  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return StreamBuilder(
        stream: bloc.stream,
        builder: (context, snapshot) {
          return Utils.handleSnapshot(
              ui: loadUI,
              onError: () {
                bloc.initNavigate();
              },
              context: context,
              snapshot: snapshot);
        });
  }

  loadUI(NavigateBlocObject object) {

    final List<Widget> _widgetOptions = <Widget>[
      const Explore(),
      const Search(),
      // const Collection(),
      const Settings()
    ];

    return Stack(
      children: <Widget>[
        CupertinoTabScaffold(
          resizeToAvoidBottomInset: false,
          tabBar: CupertinoTabBar(
            iconSize: 25,
            activeColor: Constant.accent,
            inactiveColor: Theme.of(context).iconTheme.color,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const Icon(CupertinoIcons.music_note),
                label: Constant.strings['explore'],
              ),
              BottomNavigationBarItem(
                icon: GestureDetector(
                  child: const Icon(CupertinoIcons.search),
                ),
                label: Constant.strings['search'],
              ),
              // BottomNavigationBarItem(
              //   icon: const Icon(Icons.library_music),
              //   label: Constant.strings['collection'],
              // ),
              BottomNavigationBarItem(
                icon: const Icon(CupertinoIcons.settings),
                label: Constant.strings['settings'],
              ),
            ],
          ),
          tabBuilder: (BuildContext context, int index) {
            return CupertinoTabView(
              builder: (BuildContext context) {
                return Container(
                  child: _widgetOptions[index],
                );
              },
            );
          },
        ),
        panel
      ],
    );
  }
}
