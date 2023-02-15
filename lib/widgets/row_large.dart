import 'package:flutter/material.dart';
import 'package:musikon_2022/objects.dart';
import '../utils/const.dart';
import '../utils/utils.dart';

class RowLarge extends StatelessWidget {
  final Song song;

  final VoidCallback onTap, onLongPress;

  const RowLarge({this.onTap, @required this.song, Key key, this.onLongPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.grey[900],
      child: Container(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.height * 0.01,
          right: MediaQuery.of(context).size.height * 0.01,
          top: MediaQuery.of(context).size.height * 0.01,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(3)),
              child: Utils.getImage(
                  song.album.cover.id,
                  MediaQuery.of(context).size.height * 0.20,
                  MediaQuery.of(context).size.height * 0.20),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.01),
            Row(
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
                Text(
                  song.name,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
            InkWell(
              onTap: () {
                // Navigator.of(context, rootNavigator: true)
                //     .push(createRoute(ArtistPage(song.userId, song.username)));
              },
              child: Text(song.userCreated.firstName + ' ' + song.userCreated.lastName,
                  style: Theme.of(context)
                      .textTheme
                      .overline
                      .copyWith(color: Colors.grey)),
            ),
          ],
        ),
      ),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
