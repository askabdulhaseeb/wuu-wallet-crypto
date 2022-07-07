import 'package:flutter/material.dart';

import '../../models/coin_market_place/coin.dart';
import '../../screens/coin_info_detail_screen/coin_info_detail_screen.dart';
import '../custom_widgets/custom_network_image.dart';

class CoinTile extends StatelessWidget {
  const CoinTile({required this.coin, this.onTap, Key? key}) : super(key: key);
  final Coin coin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    const String coinIconUrl =
        'https://s2.coinmarketcap.com/static/img/coins/64x64/';
    return InkWell(
      onTap: onTap ??
          () {
            Navigator.of(context).push(MaterialPageRoute<CoinInfoDetailScreen>(
              builder: (BuildContext context) =>
                  CoinInfoDetailScreen(coin: coin),
            ));
          },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            // Coin Icon
            SizedBox(
              height: 50,
              width: 50,
              child: CustomNetworkImage(
                  imageURL: (('$coinIconUrl${coin.id}.png').toLowerCase())),
            ),
            // Coin Info
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    coin.symbol,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${coin.quote.usd.percentChange24H.toStringAsFixed(2)}%',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            // Graph
            const Expanded(
                child: Center(
              child: Text(
                'Graph here',
                style: TextStyle(color: Colors.grey),
              ),
            )),
            // Amount info
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    coin.quote.usd.price.toStringAsFixed(1),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${coin.quote.usd.marketCapDominance.toStringAsFixed(2)}%',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
