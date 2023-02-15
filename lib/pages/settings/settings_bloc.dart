import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musikon_2022/utils/const.dart';
import 'package:musikon_2022/utils/utils.dart';
import 'package:rxdart/rxdart.dart';
import '../../blocs/bloc.dart';
import '../../utils/transition.dart';
import '../login_page/login.dart';

class SettingsBloc extends Bloc {
  BehaviorSubject settings = BehaviorSubject();
  CombineLatestStream stream;

  SettingsBloc() {
    stream = CombineLatestStream(
      [
        isLoading.stream,
        settings.stream,
      ],
      (values) => SettingsBlocObject(
        isLoading: values[0],
        settings: values[1],
      ),
    );
    init();
  }

  init() async {
    getSettings();
  }

  getSettings() async {
    settings.add(await repository.getSettings());
  }

  @override
  dispose() {
    settings.close();
  }

  logOut(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(Constant.strings['alert_logout_title']),
              content: Text(
                Constant.strings['alert_logout_body'],
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text(Constant.strings['alert_logout_button']),
                  isDefaultAction: true,
                  onPressed: () async {
                    Utils.clearRefreshToken();
                    Navigator.of(context, rootNavigator: true)
                        .pushReplacement(createRoute(const LoginPage()));
                  },
                ),
                CupertinoDialogAction(
                  child: Text(Constant.strings['alert_logout_button_cancel']),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }
}

class SettingsBlocObject {
  bool isLoading;
  dynamic settings;

  SettingsBlocObject({this.isLoading, this.settings});
}
