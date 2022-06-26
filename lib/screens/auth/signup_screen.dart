import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../utilities/app_images.dart';
import '../../utilities/custom_validators.dart';
import '../../widget/auth/on_continue_with_text_widget.dart';
import '../../widget/custom_widgets/custom_elevated_button.dart';
import '../../widget/custom_widgets/custom_textformfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  static const String routeName = '/SignupScreen';
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _email = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 54, vertical: 16),
              child: Image.asset(AppImages.logo4x),
            ),
            const SizedBox(height: 40),
            const Text(
              'What’s your \nemail address!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            CustomTextFormField(
              controller: _email,
              lable: 'Email Address',
              hint: 'example@example.com',
              readOnly: isLoading,
              validator: (String? value) => CustomValidator.email(value),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 10),
            CustomElevatedButton(
              title: 'Continue with Email',
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.mail, color: Colors.white),
              ),
              onTap: () {},
            ),
            const SizedBox(height: 10),
            const _Footer(),
          ],
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const OrContinueWithTextWidget(),
          Row(
            children: <Widget>[
              _IconButton(
                imagePath: AppImages.google,
                onTap: () {},
              ),
              _IconButton(
                icon: Icons.apple,
                onTap: () {},
              ),
            ],
          ),
          Center(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.grey),
                children: <TextSpan>[
                  const TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextSpan(
                    text: ' Sign In',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    required this.onTap,
    this.icon,
    this.imagePath,
    Key? key,
  }) : super(key: key);
  final IconData? icon;
  final String? imagePath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 48,
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: FittedBox(
              child: (icon != null)
                  ? Icon(icon!)
                  : imagePath != null
                      ? Image.asset(imagePath!, fit: BoxFit.fitHeight)
                      : const Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}
