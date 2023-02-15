import 'package:flutter/material.dart';
import 'package:musikon_2022/pages/wrapper/wrapper_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../widgets/notice.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  WrapperBloc wrapperBloc = WrapperBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    wrapperBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: wrapperBloc.user,
        builder: (context, snapshot) {
          return wrapperBloc.handleEvent(snapshot, context);
        });
  }
}
