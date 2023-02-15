import 'package:flutter/material.dart';
import 'package:musikon_2022/blocs/player_singleton.dart';
import 'package:musikon_2022/utils/song_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../utils/repository.dart';

class Bloc {
  Repository repository = Repository();
  SongRepository songRepository = SongRepository();
  BehaviorSubject id = BehaviorSubject<String>();
  PlayerSingleton playerSingleton = PlayerSingleton();
  BehaviorSubject isLoading = BehaviorSubject<bool>();

  Bloc() {
    isLoading.add(false);
  }

  void dispose() {
    isLoading.close();
    id.close();
  }

  getId() async {

    var result = await songRepository.getUserId();

    if (result != null) {
      id.add(result);
    } else {
      id.addError("ExploreBloc.getId");
    }
  }

  setLoading(bool value) {
    isLoading.add(value);
  }

  sendMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
    ));
  }
}
