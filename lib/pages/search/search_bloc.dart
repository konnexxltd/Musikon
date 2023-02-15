import 'package:flutter/material.dart';
import 'package:musikon_2022/objects.dart';
import 'package:rxdart/rxdart.dart';
import '../../blocs/bloc.dart';

class SearchBloc extends Bloc {
  CombineLatestStream stream;
  ScrollController controller = ScrollController();
  BehaviorSubject<List<Song>> songs = BehaviorSubject<List<Song>>();
  final searchController = TextEditingController();

  SearchBloc() {
    stream = CombineLatestStream(
      [
        isLoading.stream,
        songs.stream,
        id.stream
      ],
      (values) => SearchBlocObject(
        isLoading: values[0],
        songs: values[1],
        id: values[2],
      ),
    );
    init();
  }

  init() async {
    searchQuery("");
    getId();
  }

  searchQuery(String text) async {
    var result = await songRepository.searchSongs(text);

    if (result != null) {
      songs.add(result);
    }else {
      songs.addError("SearchBloc.searchQuery");
    }
  }
}

class SearchBlocObject {
  bool isLoading;
  List<Song> songs;
  String id;

  SearchBlocObject({
    this.isLoading,
    this.songs,
    this.id
  });
}
