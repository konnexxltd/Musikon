import 'package:flutter/cupertino.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../utils/const.dart';
import '../../utils/utils.dart';
import '../../widgets/space.dart';
import 'collection_bloc.dart';

class Collection extends StatefulWidget {
  const Collection({Key key}) : super(key: key);

  @override
  State<Collection> createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {
  CollectionBloc bloc = CollectionBloc();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.stream,
        builder: (context, snapshot) {
          return Utils.handleSnapshot(
              ui: loadUI,
              context: context,
              snapshot: snapshot,
              title: Constant.strings['collection']);
        });
  }

  @override
  dispose() {
    bloc.dispose();
    super.dispose();
  }

  loadUI(CollectionBlocObject object) {
    List<Widget> list = [];

    var recentlyPlayed = Utils.parseRow(
      title: Constant.strings["recently_played"],
      subtitle: Constant.strings["recently_played_subtitle"],
      songs: object.recentlyPlayed.songs,
      display: Constant.displayLarge,
      singleton: bloc.playerSingleton,
      context: context,
      id: object.id
    );

    var favorites = Utils.parseRow(
      title: Constant.strings["favourites"],
      subtitle: Constant.strings["favourites_subtitle"],
      songs: object.favourites.songs,
      display: Constant.displaySmall,
      singleton: bloc.playerSingleton,
      context: context,
      id: object.id
    );

    list.add(recentlyPlayed);

    list.add(favorites);

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: CustomScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          controller: bloc.controller,
          slivers: [
            CupertinoSliverRefreshControl(
              onRefresh: () {
                return bloc.init();
              },
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),
            MultiSliver(children: list),
            const SpaceWidget()
          ]),
    );
  }
}
