import 'package:flutter/material.dart';

class SpaceWidget extends StatelessWidget {
  const SpaceWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate.fixed(
        [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          )
        ],
      ),
    );
  }
}
