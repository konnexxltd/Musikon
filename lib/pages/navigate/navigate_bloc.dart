import 'package:rxdart/rxdart.dart';
import '../../blocs/bloc.dart';

class NavigateBloc extends Bloc {
  CombineLatestStream stream;

  NavigateBloc() {
    stream = CombineLatestStream(
      [
        isLoading.stream,
      ],
      (values) => NavigateBlocObject(
        isLoading: values[0],
      ),
    );
    initNavigate();
  }

  initNavigate() async {
    isLoading.add(true);
    var result = await songRepository.initClient();
    if (result == null) {
      isLoading.addError('initNavigate');
    } else {
      isLoading.add(false);
    }
  }

}

class NavigateBlocObject {
  bool isLoading;

  NavigateBlocObject({
    this.isLoading,
  });
}
