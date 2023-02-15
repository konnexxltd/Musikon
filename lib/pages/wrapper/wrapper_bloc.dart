import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:musikon_2022/blocs/bloc.dart';
import 'package:musikon_2022/utils/utils.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:rxdart/rxdart.dart';
import '../../utils/const.dart';
import '../../widgets/notice.dart';
import '../loading_page.dart';
import '../login_page/login.dart';
import '../navigate/navigate.dart';
import '../no_connection_page.dart';

class WrapperBloc extends Bloc {
  BehaviorSubject<bool> user = BehaviorSubject();

  WrapperBloc() {
    initWrapper();
  }

  initWrapper() async {
    await Utils.configureApp();
    updateWrapper();
  }

  updateWrapper() async {
    Constant.strings = await repository.getStrings();

    String token = await Utils.getRefreshToken();

    if (token == null) {
      user.add(false);
    } else {
      await repository.refreshAccessToken();
      user.add(true);
    }
  }

  Widget handleEvent(AsyncSnapshot snapshot, BuildContext context) {
    DeviceScreenType deviceType = getDeviceType(MediaQuery.of(context).size);
    Widget child = const LoadingPage();
    if (snapshot.hasData) {
      if (snapshot.data == true) {
        child = const Navigate();
      } else {
        child = const LoginPage();
      }
      if (deviceType != DeviceScreenType.mobile || !kIsWeb) {
        child = const Notice();
      }
    }

    if (snapshot.hasError) {
      child = NoConnectionPage(
        onPressed: () {
          updateWrapper();
        },
      );
    }

    return AnimatedSwitcher(
      duration: Duration(milliseconds: Constant.load),
      child: child,
    );
  }

  @override
  dispose() {
    user.close();
  }
}
