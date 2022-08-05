import 'dart:developer';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../apis/coins_api.dart';
import '../../apis/exchange_api.dart';
import '../../apis/local_data.dart';
import '../../models/coin_market_place/coin.dart';
import '../../models/swapable_coin.dart';
import '../../widget/custom_widgets/custom_textformfield.dart';
import '../../widget/custom_widgets/show_loading.dart';

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
          child: FutureBuilder<List<SwapableCoin>>(
              future: ExchangeAPI().swapableCoins(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<SwapableCoin>> snapshot) {
                log(LocalData.privateKey().toString());
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else if (snapshot.hasData) {
                  final List<SwapableCoin> swapableCoin =
                      snapshot.data ?? <SwapableCoin>[];
                  final int index = swapableCoin.indexWhere(
                    (SwapableCoin element) =>
                        element.symbol == widget.coin.symbol.toUpperCase(),
                  );
                  log(swapableCoin[index].symbol.toString());
                  log(swapableCoin[index].contractAddress.toString());
                  return index < 0
                      ? const Center(child: Text('Transation not possible'))
                      : Column(
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
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            TextFormField(
                              controller: _amount,
                              textAlign: TextAlign.center,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              style: const TextStyle(
                                color: Colors.yellow,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                              onChanged: (String? value) async {
                                if (value == null || value.isEmpty) return;
                                final Map<String, dynamic>? result =
                                    await CoinsAPI().coinTranfer(
                                  amount: double.parse(_amount.text),
                                  toAddress: _address.text.trim(),
                                  coinName: widget.coin.symbol,
                                  contractAddress:
                                      swapableCoin[index].contractAddress,
                                  getFee: true,
                                );
                                print(result);
                              },
                              decoration: const InputDecoration(
                                fillColor: Colors.yellow,
                                border: InputBorder.none,
                              ),
                            ),
                            const SizedBox(height: 64),
                            const Text(
                              'Advanced',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
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
                                        maxLines: 5,
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
                        );
                } else {
                  return const ShowLoading();
                }
              }),
        ),
      ),
    );
  }
}
