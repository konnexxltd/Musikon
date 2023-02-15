import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../utils/const.dart';

class Notice extends StatelessWidget {
  const Notice({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImage(
              data: Constant.strings['notice_url'],
              version: QrVersions.auto,
              backgroundColor: Colors.white,
              size: 200.0,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              Constant.strings['notice_description'],
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).textTheme.headline6.color),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}