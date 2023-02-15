import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../utils/const.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const EmptyState({Key key, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverToBoxAdapter(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SizedBox(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Icon(Feather.music),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    Constant.strings["nothing_here_state"],
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(color: Colors.grey),
                  ),
                ),
                InkWell(
                  onTap: onTap,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      color: Constant.accent,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.caption.copyWith(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}
