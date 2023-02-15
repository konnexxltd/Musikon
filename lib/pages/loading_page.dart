import 'package:flutter/material.dart';

import '../utils/const.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icon.png",
              height: 100,
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Constant.accent),
              ),
              height: 20,
              width: 20,
            )
          ],
        ),
      ),
    );
  }
}
