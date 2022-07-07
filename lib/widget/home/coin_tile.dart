import 'package:flutter/material.dart';

import '../../models/coin_market_place/coin.dart';
import '../custom_widgets/custom_network_image.dart';

class CoinTile extends StatelessWidget {
  const CoinTile({required this.coin, Key? key}) : super(key: key);
  final Coin coin;

  @override
  Widget build(BuildContext context) {
    const String coinIconUrl =
        'https://s2.coinmarketcap.com/static/img/coins/64x64/';
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          height: 70,
          child: Row(
            children: <Widget>[
              // Coin Icon
              SizedBox(
                height: 50,
                width: 50,
                child: CustomNetworkImage(
                    imageURL: (('$coinIconUrl${coin.id}.png').toLowerCase())),
              ),
              const SizedBox(width: 10),
              // Coin Info
              Column(
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
              const SizedBox(width: 10),
              // Graph
              const Expanded(
                  child: Center(
                child: Text(
                  'Graph here',
                  style: TextStyle(color: Colors.grey),
                ),
              )),
              // Amount info
              const SizedBox(width: 10),
              Column(
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
            ],
          ),
        ),
      ),
    );
  }
}
