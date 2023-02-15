import 'package:flutter/material.dart';
import 'package:musikon_2022/objects.dart';
import 'package:musikon_2022/utils/const.dart';

class TitleWidget extends StatelessWidget {
  final String title, subtitle;
  final VoidCallback onTap;
  const TitleWidget({Key key, this.title, this.subtitle, this.onTap, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(letterSpacing: 1.1),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              subtitle,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Colors.grey, fontSize: 11),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
        const Spacer(),
        if(onTap!=null)
        InkWell(
          child: Text(
            Constant.strings["view_all"],
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          onTap: onTap,
        )
      ],
    );
  }
}
