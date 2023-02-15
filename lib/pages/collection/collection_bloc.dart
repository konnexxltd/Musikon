import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:musikon_2022/objects.dart';
import 'package:musikon_2022/utils/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../../blocs/bloc.dart';

class CollectionBloc extends Bloc {
  CombineLatestStream stream;
  ScrollController controller = ScrollController();
  BehaviorSubject<Collection> recentlyPlayed = BehaviorSubject();
  BehaviorSubject<Collection> favourites = BehaviorSubject();

  CollectionBloc() {
    stream = CombineLatestStream(
      [isLoading.stream, recentlyPlayed.stream, favourites.stream, id.stream],
      (values) => CollectionBlocObject(
          isLoading: values[0],
          recentlyPlayed: values[1],
          favourites: values[2],
          id: values[3]),
    );
    init();
  }

  init() async {
    getRecentlyPlayed();
    getFavourites();
    getId();
  }

  getRecentlyPlayed() async {
    var result = await songRepository.recentlyPlayed();

    if (result != null) {
      recentlyPlayed.add(result);
    } else {
      recentlyPlayed.addError("CollectionBloc.getRecentlyPlayed");
    }
  }

  getFavourites() async {
    var result = await songRepository.favourites();

    if (result != null) {
      favourites.add(result);
    } else {
      favourites.addError("CollectionBloc.getFavourites");
    }
  }

  @override
  void dispose() {
    recentlyPlayed.close();
    favourites.close();
    super.dispose();
  }
}

class CollectionBlocObject {
  bool isLoading;
  Collection recentlyPlayed;
  Collection favourites;
  String id;

  CollectionBlocObject(
      {this.isLoading, this.recentlyPlayed, this.favourites, this.id});
}
