import 'package:flutter/cupertino.dart';
import 'package:musikon_2022/utils/const.dart';
import 'package:musikon_2022/utils/transition.dart';
import 'package:rxdart/rxdart.dart';
import '../../blocs/bloc.dart';
import '../navigate/navigate.dart';

class LoginBloc extends Bloc {
  CombineLatestStream stream;
  TextEditingController email = TextEditingController(),
      password = TextEditingController();

  LoginBloc() {
    stream = CombineLatestStream(
      [
        isLoading.stream,
      ],
      (values) => LoginBlocObject(
        isLoading: values[0],
      ),
    );
  }

  handleLogin(BuildContext context) async {
    isLoading.add(true);

    if (email.text.isEmpty || password.text.isEmpty) {
      sendMessage(Constant.strings["empty_fields"], context);
      isLoading.add(false);
      return;
    }

    var result = await repository.login(email.text, password.text);

    if (result == null) {
      sendMessage(Constant.strings["login_failed"], context);
      isLoading.add(false);
      return;
    }

    Navigator.pushReplacement(context, createRoute(const Navigate()));


    // Handle Successful Login here

    isLoading.add(false);
    return;
  }
}

class LoginBlocObject {
  bool isLoading;

  LoginBlocObject({
    this.isLoading,
  });
}
