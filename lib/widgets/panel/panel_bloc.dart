import 'package:musikon_2022/objects.dart';
import 'package:rxdart/rxdart.dart';

import '../../blocs/bloc.dart';

class PanelBloc extends Bloc {
  CombineLatestStream stream;

  PanelBloc() {
    stream = CombineLatestStream([
      playerSingleton.currentSong.stream,
      playerSingleton.state.stream,
    ], (streams) => PanelBlocObject(song: streams[0], state: streams[1]));
  }
}

class PanelBlocObject {
  Song song;
  String state;

  PanelBlocObject({this.song, this.state});
}
