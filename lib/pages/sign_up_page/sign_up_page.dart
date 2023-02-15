import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musikon_2022/pages/sign_up_page/sign_up_bloc.dart';
import '../../utils/const.dart';
import '../../utils/utils.dart';
import '../../widgets/iconbutton.dart';
import '../../widgets/textfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SignUpBloc bloc = SignUpBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.stream,
        builder: (context, snapshot) {

          return Utils.handleSnapshot(
              ui: loadUI, context: context, snapshot: snapshot);
        });
  }

  loadUI(SignUpBlocObject object) {
    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: [
                  ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context).scaffoldBackgroundColor,
                          Colors.transparent
                        ],
                      ).createShader(
                          Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    blendMode: BlendMode.dstIn,
                    child: Image.asset(
                      "assets/party.gif",
                      height: MediaQuery.of(context).size.height * 0.4,
                      fit: BoxFit.cover,
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      color: Theme.of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Image.asset(
                        "assets/icon.png",
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        Constant.strings['app_name'],
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.headline6.color),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        Constant.strings['sign_up_page_title'],
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.headline6.color),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        Constant.strings['sign_up_page_subtitle'],
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Theme.of(context).textTheme.headline6.color),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 20),
                child: Field(
                    value: Constant.strings['email_address'],
                    controller: bloc.email,
                    obscure: false,
                    suffix: Icons.email,
                    enabled: true),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 20),
                child: Field(
                    value: Constant.strings['password'],
                    controller: bloc.password,
                    obscure: true,
                    suffix: Icons.password,
                    enabled: true),
              ),
              IconButtonWidget(
                  buttonText: Constant.strings['sign_up'],
                  buttonColor: Colors.grey[900],
                  onPressed: () async {
                    bloc.handleSignUp(context);
                  },
                  icon: const Icon(CupertinoIcons.profile_circled)),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Constant.strings['account_already'],
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 5,
                      ),
                      child: InkWell(
                        child: Text(
                          Constant.strings['click_here'],
                          style: TextStyle(
                              fontSize: 14,
                              color: Constant.accent,
                              fontWeight: FontWeight.w500),
                        ),
                        onTap: () {
                          Navigator.pop(context) ;
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
