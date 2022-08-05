import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../apis/local_data.dart';
import '../../models/coin_market_place/coin.dart';

class ReceiveBTCScreen extends StatelessWidget {
  const ReceiveBTCScreen({required this.coin, Key? key}) : super(key: key);
  final Coin coin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Receive BTC'.toUpperCase())),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: ExtendedImage.network(
                    coin.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              LocalData.privateKeyAddress() == null
                  ? const SizedBox()
                  : QrImage(
                      data: LocalData.privateKeyAddress()!,
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
                    text: LocalData.privateKeyAddress(),
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
                          LocalData.privateKeyAddress() ?? 'issue in address',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await Clipboard.setData(ClipboardData(
                            text: LocalData.privateKeyAddress(),
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
