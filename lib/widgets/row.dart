import 'package:flutter/material.dart';
import 'package:musikon_2022/objects.dart';

import '../utils/const.dart';
import '../utils/utils.dart';

class RowSmall extends StatelessWidget {
  final Song song;
  final VoidCallback onTap, onLongPress;

  const RowSmall({@required this.song, Key key, this.onTap, this.onLongPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListTileTheme(
        selectedColor: Colors.cyan,
        textColor: Colors.white,
        child: InkWell(
          onTap: onTap,
          highlightColor: Colors.grey[900],
          child: ListTile(
            contentPadding: const EdgeInsets.only(left: 10),
            dense: false,
            visualDensity: VisualDensity.comfortable,
            leading: Utils.getImage(
                song.album.cover.id,
                MediaQuery.of(context).size.height * 0.05,
                MediaQuery.of(context).size.height * 0.05),
            trailing: IconButton(
              splashColor: Theme.of(context).scaffoldBackgroundColor,
              highlightColor: Theme.of(context).scaffoldBackgroundColor,
              icon: const Icon(Icons.more_horiz),
              color: Theme.of(context).iconTheme.color,
              iconSize: 20,
              onPressed: onLongPress,
            ),
            selected: false,
            title: Row(
              children: [
                if (song.explicit)
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Icon(
                      Icons.explicit,
                      color: Constant.accent,
                      size: 20,
                    ),
                  ),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  song.name,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
            subtitle: InkWell(
              onTap: () {
                // Navigator.of(context, rootNavigator: true)
                //     .push(createRoute(ArtistPage(song.id, song.user.name)));
              },
              child: Text(
                song.userCreated.firstName + ' ' + song.userCreated.lastName,
                style: Theme.of(context)
                    .textTheme
                    .overline
                    .copyWith(color: Colors.grey),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
