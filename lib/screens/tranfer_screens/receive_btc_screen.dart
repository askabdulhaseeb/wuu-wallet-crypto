import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../apis/local_data.dart';
import '../../backend/encrypt.dart';
import '../../helpers/app_config.dart';

class ReceiveBTCScreen extends StatelessWidget {
  ReceiveBTCScreen({Key? key}) : super(key: key);
  EncryptApp _encryptApp = EncryptApp();
  String? btcAddress;
  @override
  Widget build(BuildContext context) {
    btcAddress = _encryptApp.appDecrypt(walletAddMap['btc_address']);
    return Scaffold(
      appBar: AppBar(title: Text('Receive BTC'.toUpperCase())),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/logos/icon.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              btcAddress == null
                  ? const SizedBox()
                  : QrImage(
                      data: btcAddress!,
                      version: QrVersions.auto,
                      size: 240.0,
                    ),
              const SizedBox(height: 16),
              const Text(
                'Your BTC Address',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              InkWell(
                onTap: () async {
                  await Clipboard.setData(ClipboardData(
                    text: walletAddMap['wallet'],
                  )).then((_) =>
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Copied to your clipboard !'),
                      )));
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          btcAddress ?? 'issue in address',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await Clipboard.setData(ClipboardData(
                            text: LocalData.keyAddress(),
                          )).then((_) => ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Copied to your clipboard !'),
                              )));
                        },
                        splashRadius: 16,
                        icon: const Icon(Icons.copy),
                      )
                    ],
                  ),
                ),
              ),
              
              const Text(
                'Tap Bicoin Address to copy',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              // const SizedBox(height: 16),
              // TextButton(
              //   onPressed: () {},
              //   child: const Text(
              //     'Share',
              //     style: TextStyle(fontSize: 32),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
