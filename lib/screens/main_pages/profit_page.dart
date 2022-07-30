import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../apis/wallet_api.dart';
import '../../widget/coin_list_view.dart';
import '../../widget/custom_widgets/show_loading.dart';

class ProfitScreen extends StatelessWidget {
  const ProfitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bitcoin Balance'),
        actions: <Widget>[
          IconButton(
            splashRadius: 20,
            onPressed: () {
              // TODO: Search Page Navigation
            },
            icon: const Icon(CupertinoIcons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const _BalanceWidget(),
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _Button(
                    title: 'Deposit',
                    icon: const Icon(
                      Icons.arrow_downward,
                      size: 18,
                      color: Colors.greenAccent,
                    ),
                    onTap: () {},
                  ),
                  _Button(
                    title: 'Withdrawal',
                    icon: const Icon(
                      Icons.arrow_upward,
                      size: 18,
                      color: Colors.greenAccent,
                    ),
                    onTap: () {},
                  ),
                  _Button(
                    title: 'Earn',
                    icon: const Icon(
                      Icons.arrow_drop_up_rounded,
                      size: 18,
                      color: Colors.greenAccent,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const CoinListView(),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.onTap,
    required this.title,
    required this.icon,
    Key? key,
  }) : super(key: key);
  final VoidCallback onTap;
  final String title;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          icon,
        ],
      ),
    );
  }
}

class _BalanceWidget extends StatefulWidget {
  const _BalanceWidget({Key? key}) : super(key: key);
  @override
  State<_BalanceWidget> createState() => _BalanceWidgetState();
}

class _BalanceWidgetState extends State<_BalanceWidget> {
  bool hiden = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Text(
              'Total Balance',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
            IconButton(
              splashRadius: 14,
              onPressed: () {
                setState(() {
                  hiden = !hiden;
                });
              },
              icon: Icon(
                hiden ? CupertinoIcons.eye : CupertinoIcons.eye_slash_fill,
                size: 18,
              ),
            ),
          ],
        ),
        FutureBuilder<double>(
          future: WalletAPI().balance(),
          builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
            if (snapshot.hasError) {
              return const Text(
                '-Error-',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              );
            } else if (snapshot.hasData) {
              final double balance = snapshot.data!;
              return SizedBox(
                height: hiden ? 14 : 50,
                child: FittedBox(
                  child: Text(
                    hiden
                        ? 'Tap on the Eye Button to show the balance \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t'
                        : '\$ $balance',
                    style: TextStyle(
                      color: hiden
                          ? Colors.grey
                          : Theme.of(context).textTheme.bodyText1!.color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            } else {
              return const ShowLoading();
            }
          },
        ),
      ],
    );
  }
}
