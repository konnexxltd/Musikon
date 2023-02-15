import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/const.dart';
import '../widgets/iconbutton.dart';


class NoConnectionPage extends StatelessWidget {
  final VoidCallback onPressed;
  const NoConnectionPage({Key key, this.onPressed,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              const Text(
                'No Internet Connection',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'Please check your internet connection and try again.',
                style: TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              IconButtonWidget(
                  buttonText: "Try Again",
                  buttonColor: Constant.accent,
                  onPressed: onPressed,
                  icon: const Icon(CupertinoIcons.refresh)),
            ],
          ),
        ),
      ),
    );
  }
}
