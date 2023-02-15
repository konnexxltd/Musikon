import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed, longPress;
  final Widget icon;

  const IconButtonWidget(
      {@required this.buttonText,
      @required this.buttonColor,
      this.textColor = Colors.white,
      @required this.onPressed,
      @required this.icon,
      this.longPress,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: buttonColor,
            height: 45,
            child: Padding(
              padding: EdgeInsets.only(
                  left: buttonText != null ? 20.0 : 50.0,
                  right: buttonText != null ? 20.0 : 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  buttonText != null ? SizedBox(width: 10) : Container(),
                  buttonText != null
                      ? Text(
                          buttonText,
                          style: Theme.of(context)
                              .textTheme
                              .button
                              .copyWith(color: textColor),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
        onLongPress: longPress,
        onTap: onPressed,
      ),
    );
  }
}
