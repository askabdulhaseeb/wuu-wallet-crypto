import 'package:flutter/material.dart';

import '../../models/coin_market_place/coin.dart';

class CoinTile extends StatelessWidget {
  const CoinTile({required this.coin, Key? key}) : super(key: key);
  final Coin coin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        height: 58,
        child: Row(
          children: <Widget>[
            // Coin Icon
            Container(
              height: 50,
              width: 50,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.amber.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
              child: FittedBox(
                child: Text(
                  coin.symbol,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
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
    );
  }
}
