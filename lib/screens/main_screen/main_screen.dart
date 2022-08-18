import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../backend/erc_20_wallet.dart';
import '../../backend/wallet_addresses.dart';
import '../../helpers/app_config.dart';
import '../../providers/app_provider.dart';
import '../../providers/exchange_provider.dart';
import '../main_pages/exchange_coin_screen.dart';
import '../main_pages/history_page.dart';
import '../main_pages/home_page.dart';
import '../main_pages/profile_page.dart';
import '../main_pages/coin_balace_page.dart';
import '../wallet_screens/create_wallet_screen/create_wallet_screen.dart';
import 'main_bottom_navigation_bar.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const String routeName = '/MainScreen';

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    CoinScreen(),
    ExchangeCoinScreen(),
    HistoryPage(),
    ProfilePage(),
  ];

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ERC20WalletAd _erc20walletAd = ERC20WalletAd();
  final WalletAd _walletAd = WalletAd();
  @override
  void initState() {
    super.initState();
    createWallet();
  }

  bool isLoading = false;

  createWallet() async {
    setState(() {
      isLoading = true;
    });
    
    try {
      walletAddMap = await _walletAd.createWallet();

      // Map? erc20Add = await _erc20walletAd.createErcWallet();

      // walletAddMap.addAll(erc20Add!);
      // walletAddMap[UID] = 'asd';
      print('walletAddMap $walletAddMap');
      // http.Response response = await http.post(
      //   Uri.parse('${url}store-wallets.php'),
      //   headers: header,
      //   body: walletAddMap,
      // );

      // var resbody = json.decode(response.body);

      // if (resbody[STATUS] == 'failed') {
      //   _callFunctions.showSnacky(resbody[MESSAGE], false, context);
      // }
    } catch (e) {
      // _callFunctions.showSnacky(DEFAULT_ERROR, false, context);

      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = Provider.of<AppProvider>(context).currentTap;
    Provider.of<ExchangeCoinProvider>(context).init();
    return Scaffold(
      body: isLoading
          ? const CircularProgressIndicator()
          : MainScreen._pages[currentIndex],
      bottomNavigationBar: const MainBottomNavigationBar(),
    );
  }
}
