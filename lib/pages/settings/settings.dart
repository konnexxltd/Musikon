import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/const.dart';
import '../../utils/utils.dart';
import 'settings_bloc.dart';

class Settings extends StatefulWidget {
  const Settings({Key key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SettingsBloc bloc = SettingsBloc();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.stream,
        builder: (context, snapshot) {
          return Utils.handleSnapshot(
              ui: loadUI,
              context: context,
              snapshot: snapshot,
              title: Constant.strings['settings']);
        });
  }

  loadUI(SettingsBlocObject object) {
    print('Settings: ${object.settings}');
    return CustomScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return settingsTile(
              title: object.settings[index]['title'],
              description: object.settings[index]['subtitle'],
              onTap: () {
                launchUrl(Uri.parse(object.settings[index]['url']));
              },
            );
          }, childCount: object.settings.length)),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          sliver: SliverList(
            delegate: SliverChildListDelegate.fixed([
              settingsTile(
                  title: Constant.strings['log_out_settings_title'],
                  description: Constant.strings['log_out_settings_subtitle'],
                  onTap: () async {
                    bloc.logOut(context);
                  },
                  icon: Icons.logout),
            ]),
          ),
        )
      ],
    );
  }

  settingsTile(
      {String title, String description, IconData icon, VoidCallback onTap}) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
      subtitle: Text(
        description,
        style: Theme.of(context).textTheme.caption,
      ),
      trailing: Icon(
        icon,
        color: Colors.white,
      ),
      onTap: onTap,
    );
  }
}
