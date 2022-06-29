import 'package:flutter/material.dart';
import '../../utilities/utilities.dart';

class TotalBalanceWidget extends StatelessWidget {
  const TotalBalanceWidget({required this.balance, Key? key}) : super(key: key);
  final double balance;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(colors: Utilities.bproGradient),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                'Total balance',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Cash available',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Text(
            '\$ $balance',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
          )
        ],
      ),
    );
  }
}
