import 'package:flutter/cupertino.dart';
import 'package:musikon_2022/utils/const.dart';
import 'package:musikon_2022/widgets/space.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../objects.dart';
import '../../utils/utils.dart';
import 'explore_bloc.dart';

class Explore extends StatefulWidget {
  const Explore({Key key}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  ExploreBloc bloc = ExploreBloc();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.stream,
        builder: (context, snapshot) {
          return Utils.handleSnapshot(
              ui: loadUI,
              context: context,
              onError: () {
                bloc.getCollection();
              },
              snapshot: snapshot,
              title: Constant.strings['explore'],
              controller: bloc.controller);
        });
  }

  @override
  dispose() {
    bloc.dispose();
    super.dispose();
  }

  loadUI(ExploreBlocObject object) {
    List<Widget> list = [];
    for (Collection collection in object.collections) {
      var row = Utils.parseRow(
        title: collection.title,
        subtitle: collection.subtitle,
        collectionId: collection.id,
        songs: collection.songs,
        display: collection.display,
        context: context,
        singleton: bloc.playerSingleton,
        id: object.id,
      );
      list.add(row);
    }

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: CustomScrollView(
          controller: bloc.controller,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            CupertinoSliverRefreshControl(
              onRefresh: () {
                return bloc.getCollection();
              },
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),
            MultiSliver(children: list),
            const SpaceWidget()
          ]),
    );
  }
}
