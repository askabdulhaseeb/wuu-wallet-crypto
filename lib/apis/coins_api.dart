import 'package:http/http.dart' as http;
import '../models/coin_market_place/coin.dart';
import '../models/coin_market_place/coin_request.dart';
import '../utilities/api_utils.dart';
import '../utilities/dome_data.dart';
import 'api_request_error.dart';

class CoinsAPI {
  Future<List<Coin>?> listingLatest() async {
    final Map<String, String> headers = {
      'X-CMC_PRO_API_KEY': APIUtils.coinMarketPlaceAPIKey,
    };
    final http.Request request = http.Request(
      'GET',
      Uri.parse(
        '${APIUtils.basicMarketPlaceAPIBaseUrlV1}/cryptocurrency/listings/latest',
      ),
    );
    request.headers.addAll(headers);
    final http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // final String respStr = await response.stream.bytesToString();
      final String respStr = await response.stream.bytesToString();
      print(respStr);
      final CoinRequest coinRequest = CoinRequest.fromJson(respStr);
      return coinRequest.coins.isNotEmpty ? coinRequest.coins : <Coin>[];
    } else {
      print('Print - Coins Listing Latest Error: ${response.statusCode}');
      APIRequestError.martketplace(response.statusCode);
      return null;
    }
  }

  Future<List<Coin>?> domeLisingLatest() async {
    await Future<dynamic>.delayed(const Duration(seconds: 1));
    final String respStr = DomeData.listingLatest();
    final CoinRequest coinRequest = CoinRequest.fromJson(respStr);
    return coinRequest.coins.isNotEmpty ? coinRequest.coins : <Coin>[];
  }
}
