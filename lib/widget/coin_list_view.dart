import 'package:flutter/material.dart';
import '../apis/coins_api.dart';
import '../models/coin_market_place/coin.dart';
import 'custom_widgets/show_loading.dart';
import 'home/coin_tile.dart';

class CoinListView extends StatelessWidget {
  const CoinListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Coin>?>(
      future: CoinsAPI().listingLatest(),
      builder: (BuildContext context, AsyncSnapshot<List<Coin>?> snapshot) {
        if (snapshot.hasData) {
          final List<Coin> coins = snapshot.data ?? <Coin>[];
          return Expanded(
            child: ListView.builder(
              itemCount: coins.length,
              itemBuilder: (BuildContext context, int index) {
                return CoinTile(coin: coins[index]);
              },
            ),
          );
        } else {
          return const ShowLoading();
        }
      },
    );
  }
}
