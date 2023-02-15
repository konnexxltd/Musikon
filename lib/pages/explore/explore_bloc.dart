import 'package:flutter/cupertino.dart';
import 'package:musikon_2022/objects.dart';
import 'package:rxdart/rxdart.dart';
import '../../blocs/bloc.dart';

class ExploreBloc extends Bloc {
  CombineLatestStream stream;
  ScrollController controller = ScrollController();
  BehaviorSubject<List<Collection>> collections = BehaviorSubject();

  ExploreBloc() {
    stream = CombineLatestStream(
      [isLoading.stream, collections.stream, id.stream],
      (values) => ExploreBlocObject(
        isLoading: values[0],
        collections: values[1],
        id: values[2],
      ),
    );
    init();
  }

  init() async {
    getCollection();
    getId();
  }

  getCollection() async {
    var result = await songRepository.getCollectionsForDashboard();

    if (result != null) {
      collections.add(result);
    } else {
      collections.addError("ExploreBloc.getCollection");
    }
  }

  @override
  void dispose() {
    collections.close();
    super.dispose();
  }
}

class ExploreBlocObject {
  bool isLoading;
  List<Collection> collections;
  String id;

  ExploreBlocObject({this.isLoading, this.collections, this.id});
}
