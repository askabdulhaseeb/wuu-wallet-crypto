import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import '../models/coin_market_place/coin.dart';
import '../utilities/api_utils.dart';
import 'api_request_error.dart';

class CoinsAPI {
  Future<List<Coin>?> listingLatest() async {
    final http.Request request = http.Request(
      'GET',
      Uri.parse('${APIUtils.walletBaseURL}/dashboard/coinlist'),
    );
    final http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final String respStr = await response.stream.bytesToString();
      Map<String, dynamic> map = json.decode(respStr);
      final List<Coin> coins = <Coin>[];
      for (dynamic element in map['coinlist']) {
        final Coin coin = Coin.fromJson(element);
        coins.add(coin);
      }
      log('Print: coins_api: Basic Coins List Count: ${coins.length}');
      return coins;
    } else {
      APIRequestError.martketplace(response.statusCode);
      return null;
    }
  }

}
