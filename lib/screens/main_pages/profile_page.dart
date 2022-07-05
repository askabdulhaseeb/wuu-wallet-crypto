import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../../widget/custom_widgets/circular_profile_image.dart';
import '../../widget/custom_widgets/custom_elevated_button.dart';
import '../../widget/custom_widgets/title_clickable_tile.dart';
import '../../widget/profile/user_profile_info_card.dart';
import '../setting_screen/setting_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(
              SettingScreen.rotueName,
            ),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Consumer<UserProvider>(
          builder: (BuildContext context, UserProvider userPro, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                UserProfileInfoCard(user: userPro.currentUser),
                const SizedBox(height: 10),
                TitleClickableTile(title: 'View Profile', onTap: () {}),
                TitleClickableTile(title: 'Push Notification', onTap: () {}),
                TitleClickableTile(title: 'Pass code lock', onTap: () {}),
                TitleClickableTile(title: 'Auto Sale', onTap: () {}),
                TitleClickableTile(title: 'Privacy policy', onTap: () {}),
                TitleClickableTile(
                  title: 'Data Recovery & Transfer',
                  onTap: () {},
                ),
                TitleClickableTile(
                  title: 'Language',
                  trailing: const Text(
                    'English',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                CustomElevatedButton(
                  title: 'Logout',
                  bgColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  textStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                  ),
                  border: Border.all(color: Theme.of(context).primaryColor),
                  onTap: () {},
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        );
      }),
    );
  }
}