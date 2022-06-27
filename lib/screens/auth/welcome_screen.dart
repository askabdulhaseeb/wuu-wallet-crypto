import 'package:flutter/material.dart';

import '../../utilities/app_images.dart';
import '../../widget/custom_widgets/custom_elevated_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/WelcomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 54, vertical: 16),
              child: Image.asset(AppImages.logo4x),
            ),
            const SizedBox(height: 20),
            const Text(
              'Hello Saman! 👋',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Welcome to Muu Wallet',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'It’s great to have you here',
              style: TextStyle(color: Colors.grey),
            ),
            const Spacer(),
            CustomElevatedButton(
              title: 'I’m ready to start!',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
