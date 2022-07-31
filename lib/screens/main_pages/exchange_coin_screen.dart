import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../apis/coins_api.dart';
import '../../apis/exchange_api.dart';
import '../../models/swapable_coin.dart';
import '../../providers/exchange_provider.dart';
import '../../utilities/app_images.dart';
import '../../widget/coin/coin_textformfield.dart';
import '../../widget/custom_widgets/custom_elevated_button.dart';
import '../../widget/custom_widgets/show_loading.dart';

class ExchangeCoinScreen extends StatefulWidget {
  const ExchangeCoinScreen({Key? key}) : super(key: key);

  @override
  State<ExchangeCoinScreen> createState() => _ExchangeCoinScreenState();
}

class _ExchangeCoinScreenState extends State<ExchangeCoinScreen> {
  final TextEditingController _fromCont = TextEditingController();
  final TextEditingController _toCont = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Exchange')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FutureBuilder<bool>(
            future: Provider.of<ExchangeCoinProvider>(context, listen: false)
                .init(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Facing Error\n${snapshot.error}'));
              } else if (snapshot.hasData) {
                return Consumer<ExchangeCoinProvider>(builder:
                    (BuildContext context, ExchangeCoinProvider exchnagePro,
                        _) {
                  return Form(
                    key: _key,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 32),
                        CoinTextFormField(
                          key: UniqueKey(),
                          controller: _fromCont,
                          coinsList: exchnagePro.fromList(),
                          selectedCoin: exchnagePro.from,
                          onCoinSelection: (SwapableCoin? value) =>
                              exchnagePro.onFromChange(value),
                          validator: (String? value) {
                            if (value == null) return 'Enter amount here';
                            final double entered = double.parse(value);
                            if (entered > exchnagePro.fromCoinBalance) {
                              return '''You don't have much balance''';
                            }
                            return null;
                          },
                        ),
                        const _DividerWidger(),
                        CoinTextFormField(
                          key: UniqueKey(),
                          controller: _toCont,
                          coinsList: exchnagePro.toList(),
                          selectedCoin: exchnagePro.to,
                          onCoinSelection: (SwapableCoin? value) =>
                              exchnagePro.onToChange(value),
                          validator: (String? value) => null,
                        ),
                        const SizedBox(height: 32),
                        CustomElevatedButton(
                          title: 'Exchange',
                          onTap: () async {
                            // if (_key.currentState!.validate()) {
                            // }
                            final Map<String, dynamic>? mapp =
                                await ExchangeAPI().amountOut(
                              from: exchnagePro.from!,
                              to: exchnagePro.to!,
                              amount: 0.0,
                              getFee: false,
                            );
                            if (mapp == null) {
                              setState(() {
                                errorText = 'Transation issue';
                              });
                              return;
                            }
                            await ExchangeAPI().tokenSwap(
                              from: exchnagePro.from!,
                              to: exchnagePro.to!,
                              firstAmount: 0.0,
                              secondAmount: 0.0,
                              path: List<String>.from(mapp['path']),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        Text(errorText,
                            style: const TextStyle(color: Colors.red)),
                      ],
                    ),
                  );
                });
              } else {
                return const ShowLoading();
              }
            }),
      ),
    );
  }
}

class _DividerWidger extends StatelessWidget {
  const _DividerWidger({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: SizedBox(
        height: 40,
        child: Row(
          children: <Widget>[
            Flexible(
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey.shade300,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: RotatedBox(
                quarterTurns: 1,
                child: Image.asset(AppImages.exchangeIcon),
              ),
            ),
            Flexible(
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey.shade300,
              ),
            )
          ],
        ),
      ),
    );
  }
}
