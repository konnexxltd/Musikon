import 'package:flutter/cupertino.dart';
import 'package:musikon_2022/utils/const.dart';
import 'package:musikon_2022/utils/transition.dart';
import 'package:musikon_2022/utils/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';
import '../../blocs/bloc.dart';
import '../navigate/navigate.dart';

class SignUpBloc extends Bloc {
  CombineLatestStream stream;
  TextEditingController email =
          TextEditingController(),
      password = TextEditingController();

  SignUpBloc() {
    stream = CombineLatestStream(
      [
        isLoading.stream,
      ],
      (values) => SignUpBlocObject(
        isLoading: values[0],
      ),
    );
  }

  handleSignUp(BuildContext context) async {
    isLoading.add(true);

    if (email.text.isEmpty || password.text.isEmpty) {
      sendMessage(Constant.strings["empty_fields"], context);
      isLoading.add(false);
      return;
    }

    String uuid = Utils.generateUUID();

    var register = await repository.register(email.text, password.text, uuid);

    if (register != null) {
      var signIn = await repository.login(email.text, password.text);

      if (signIn == null) {
        sendMessage(Constant.strings["login_failed"], context);
        isLoading.add(false);
      }

      Navigator.pushReplacement(context, createRoute(const Navigate()));

      return;
    } else {
      sendMessage(Constant.strings["register_failed"], context);
    }

    isLoading.add(false);
    return;
  }
}

class SignUpBlocObject {
  bool isLoading;

  SignUpBlocObject({
    this.isLoading,
  });
}
