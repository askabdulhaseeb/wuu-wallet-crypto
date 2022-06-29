import 'package:flutter/material.dart';

import '../../widget/custom_widgets/title_clickable_tile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);
  static const String rotueName = '/SettingScreen';

  @override
  Widget build(BuildContext context) {
    const TextStyle trailingTextStyle =
        TextStyle(color: Colors.grey, fontSize: 13);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TitleClickableTile(
                title: 'Currency',
                onTap: () {},
                trailing: Text(
                  'usd'.toUpperCase(),
                  style: trailingTextStyle,
                ),
              ),
              TitleClickableTile(
                title: 'Appearance',
                onTap: () {},
              ),
              TitleClickableTile(
                title: 'Color Preference',
                trailing: Row(
                  children: const <Widget>[
                    Icon(
                      Icons.arrow_upward,
                      color: Colors.greenAccent,
                      size: 13,
                    ),
                    Icon(
                      Icons.arrow_downward,
                      color: Colors.redAccent,
                      size: 13,
                    ),
                  ],
                ),
                onTap: () {},
              ),
              TitleClickableTile(
                title: 'Clear Cache',
                trailing: const Text('1.18 MB', style: trailingTextStyle),
                onTap: () {},
              ),
              TitleClickableTile(
                title: 'Network test',
                onTap: () {},
              ),
              TitleClickableTile(
                title: 'Cortificate Trust Settings',
                onTap: () {},
              ),
              TitleClickableTile(
                title: 'About Us',
                trailing: const Text('v2.36.2', style: trailingTextStyle),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
