import 'package:flutter/material.dart';

import '../utils/const.dart';

class UpButton extends StatelessWidget {
  final ScrollController scrollController;

  const UpButton(this.scrollController, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: InkWell(
        child: Icon(
          Icons.keyboard_arrow_up,
          color: Constant.accent,
        ),
        onTap: () {
          scrollController.animateTo(0.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut);
        },
      ),
    );
  }
}
