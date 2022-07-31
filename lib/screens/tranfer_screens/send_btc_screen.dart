import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../models/coin_market_place/coin.dart';
import '../../widget/custom_widgets/custom_textformfield.dart';

class SendBTCScreen extends StatefulWidget {
  const SendBTCScreen({required this.coin, Key? key}) : super(key: key);
  final Coin coin;

  @override
  State<SendBTCScreen> createState() => _SendBTCScreenState();
}

class _SendBTCScreenState extends State<SendBTCScreen> {
  final TextEditingController _amount = TextEditingController(text: '0.00');
  final TextEditingController _address = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SEND BTC'),
      ),
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
                  child: ExtendedImage.network(widget.coin.image,
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Enter Amount',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              TextFormField(
                controller: _amount,
                textAlign: TextAlign.center,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                style: const TextStyle(
                  color: Colors.yellow,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  fillColor: Colors.yellow,
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 64),
              const Text(
                'Advanced',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Center(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: CustomTextFormField(
                          controller: _address,
                          border: InputBorder.none,
                          hint: 'Tap to paste address...',
                        ),
                      ),
                      IconButton(
                        splashRadius: 16,
                        onPressed: () {},
                        icon: const Icon(Icons.qr_code),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Send',
                  style: TextStyle(fontSize: 32),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
