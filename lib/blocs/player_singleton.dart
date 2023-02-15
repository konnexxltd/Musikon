
import 'dart:developer';

import 'package:just_audio/just_audio.dart';
import 'package:musikon_2022/objects.dart';
import 'package:musikon_2022/utils/repository.dart';
import 'package:rxdart/rxdart.dart';

import '../utils/const.dart';

class PlayerSingleton {
  static final PlayerSingleton _singleton = PlayerSingleton._internal();
  BehaviorSubject currentSong;
  BehaviorSubject state;
  final player = AudioPlayer();

  initStreams() async {
    currentSong = BehaviorSubject();
    state = BehaviorSubject.seeded(Constant.paused);
  }

  playSong(Song song) async {
    currentSong.add(song);
    await player.setUrl('${Repository.url}/assets/${song.songFile.id}');
    player.play();
    changeState(Constant.playing);
  }

  changeState(String state) async {
    log("changeState: $state");
    if (state == Constant.playing) {
       player.play();
      this.state.add(Constant.playing);
    } else {
       player.pause();
      this.state.add(Constant.paused);
    }
  }

  dispose() {
    currentSong.close();
    state.close();
  }

  factory PlayerSingleton() {
    return _singleton;
  }

  PlayerSingleton._internal() {
    initStreams();
  }
}
