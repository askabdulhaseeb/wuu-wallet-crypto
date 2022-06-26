import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationPinScreen extends StatefulWidget {
  const VerificationPinScreen({Key? key}) : super(key: key);
  static const String routeName = '/VarificationPicScreen';
  @override
  State<VerificationPinScreen> createState() => _VerificationPinScreenState();
}

class _VerificationPinScreenState extends State<VerificationPinScreen> {
  final TextEditingController _pin = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            const Text(
              'Verification code',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'We have sent the code verification to your mobile number',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 48),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PinCodeTextField(
                appContext: context,
                length: 4,
                cursorColor: Theme.of(context).primaryColor,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(16),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  errorBorderColor: Colors.red,
                  activeColor: Colors.grey,
                  inactiveColor: Colors.grey,
                ),
                onChanged: (String value) {},
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              child: const Text('Resend Code'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
