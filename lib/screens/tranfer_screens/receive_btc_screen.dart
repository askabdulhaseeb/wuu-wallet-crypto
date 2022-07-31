import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
              const Icon(Icons.qr_code, size: 300),
              const SizedBox(height: 16),
              const Text(
                'Your BTC Address',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              InkWell(
                onTap: () {
                  Clipboard.setData(
                    ClipboardData(
                      text: LocalData.privateKey(),
                    ),
                  );
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
                  child: Text(
                    LocalData.privateKey() ?? 'issue in address',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const Text(
                'Tap Bicoin Address to copy',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Share',
                  style: TextStyle(fontSize: 32),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
