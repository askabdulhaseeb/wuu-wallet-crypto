import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../../widget/coin_list_view.dart';
import '../../widget/custom_widgets/circular_profile_image.dart';
import '../../widget/home/total_balance_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider _userPro = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: CircularProfileImage(imageURL: _userPro.currentUser.imageURL),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.search,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.qrcode_viewfinder,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hello, \n${_userPro.currentUser.name}! 👋',
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const TotalBalanceWidget(balance: 41538),
            const _SeeAll(),
            const CoinListView(),
          ],
        ),
      ),
    );
  }
}

class _SeeAll extends StatelessWidget {
  const _SeeAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Text(
          'Markets',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('See All'),
        ),
      ],
    );
  }
}
