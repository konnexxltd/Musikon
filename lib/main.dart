import 'package:flutter/material.dart';
import 'package:musikon_2022/pages/wrapper/wrapper.dart';
import 'package:musikon_2022/utils/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Musikon',
      themeMode: ThemeMode.dark,
      showSemanticsDebugger: false,
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
          textTheme: const TextTheme(
              headline6: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              headline5: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600)),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent),
      home: const Wrapper(),
    );
  }
}