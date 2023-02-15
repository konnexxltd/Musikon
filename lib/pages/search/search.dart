import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musikon_2022/widgets/textfield.dart';
import '../../utils/const.dart';
import '../../utils/utils.dart';
import '../../widgets/row.dart';
import '../../widgets/space.dart';
import '../song_menu.dart';
import 'search_bloc.dart';

class Search extends StatefulWidget {
  const Search({Key key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  SearchBloc bloc = SearchBloc();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.stream,
        builder: (context, snapshot) {
          return Utils.handleSnapshot(
              ui: loadUI,
              context: context,
              snapshot: snapshot,
              title: Constant.strings['search'],
              controller: bloc.controller);
        });
  }

  loadUI(SearchBlocObject object) {
    return CustomScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      controller: bloc.controller,
      slivers: [
        SliverPadding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([getSearchBar(context)])),
        ),
        // List of RowSmall
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return RowSmall(
            song: object.songs[index],
            onTap: () {
              bloc.playerSingleton.playSong(object.songs[index]);
            },
            onLongPress: () {
              showDialog(
                context: context,
                barrierColor:
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
                builder: (BuildContext context) => Menu(
                  song: object.songs[index],
                ),
              );
            },
          );
        }, childCount: object.songs.length)),

        const SpaceWidget()
      ],
    );
  }

  Widget getSearchBar(BuildContext context) {
    return Field(
        value: Constant.strings['search_bar_text'],
        controller: bloc.searchController,
        onSubmitted: (text) {
          bloc.searchQuery(text);
        },
        obscure: false,
        suffix: CupertinoIcons.search,
        label: null,
        enabled: true);
  }
}
