import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:k_chart/utils/index.dart';
import '../models/swapable_coin.dart';
import '../utilities/api_utils.dart';
import '../widget/custom_widgets/custom_toast.dart';
import 'local_data.dart';

class ExchangeAPI {
  Future<List<SwapableCoin>> swapableCoins() async {
    final List<SwapableCoin> coins = <SwapableCoin>[];
    try {
      final http.Request request = http.Request(
        'GET',
        Uri.parse('${APIUtils.walletBaseURL}/swap/coinlist'),
      );
      final http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final String respStr = await response.stream.bytesToString();
        Map<String, dynamic> map = json.decode(respStr);
        for (dynamic element in map['coinList']) {
          final SwapableCoin coin = SwapableCoin.fromJson(element);
          coins.add(coin);
        }
        log('Print: coins_api: Swapable Coins List Count: ${coins.length}');
      }
      return coins;
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
      log('Print: coin_api: Swapable coin list error: ${e.toString()}');
      return coins;
    }
  }

  Future<double> coinBalance({required SwapableCoin from}) async {
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };
    final http.Request request = http.Request(
      'POST',
      Uri.parse('${APIUtils.walletBaseURL}/swap/getCoinbalance'),
    );
    request.body = json.encode(<String, dynamic>{
      'accounts': LocalData.privateKeyAddress(),
      'coin': from.symbol.toUpperCase(),
      'contractAddress': from.contractAddress,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final String respStr = await response.stream.bytesToString();
      Map<String, dynamic> map = json.decode(respStr);
      return double.parse(map['balance']?.toString() ?? '0.0');
    } else {
      CustomToast.errorToast(message: 'Balance fetching issue');
      return 0.0;
    }
  }

  Future<Map<String, dynamic>?> amountOut({
    required SwapableCoin from,
    required SwapableCoin to,
    required double amount,
    bool enterSecond = false,
    bool getFee = true,
  }) async {
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };
    final http.Request request = http.Request(
      'POST',
      Uri.parse('${APIUtils.walletBaseURL}/swap/getAmountsOut'),
    );
    request.body = json.encode(<String, dynamic>{
      'accounts': LocalData.privateKeyAddress(),
      'amount': amount,
      'enterSecondAmount': enterSecond,
      'firstSymbol': from.symbol.trim().toUpperCase(),
      'secondSymbol': to.symbol.trim().toUpperCase(),
      'firstContractAddress': from.contractAddress.trim(),
      'secondContractAddress': to.contractAddress.trim(),
      'getFee': getFee
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final String respStr = await response.stream.bytesToString();
      Map<String, dynamic> map = json.decode(respStr);
      print(map);
      return map;
    } else {
      CustomToast.errorToast(message: 'Balance fetching issue');
      return null;
    }
  }

  Future<void> tokenSwap({
    required SwapableCoin from,
    required SwapableCoin to,
    required double firstAmount,
    required double secondAmount,
    required List<String> path,
    bool enterSecond = false,
    bool getFee = true,
  }) async {
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };
    final http.Request request = http.Request(
      'POST',
      Uri.parse('${APIUtils.walletBaseURL}/swap/getAmountsOut'),
    );
    request.body = json.encode(<String, dynamic>{
      'user_id': LocalData.email(),
      'accounts': LocalData.privateKeyAddress(),
      'privateKey': LocalData.privateKey(),
      'amount1': firstAmount,
      'amount2': secondAmount,
      'path': path,
      'enterSecondAmount': enterSecond,
      'firstSymbol': from.symbol.trim().toUpperCase(),
      'secondSymbol': to.symbol.trim().toUpperCase(),
      'firstContractAddress': from.contractAddress.trim(),
      'secondContractAddress': to.contractAddress.trim(),
      'getFee': false
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final String respStr = await response.stream.bytesToString();
      Map<String, dynamic> map = json.decode(respStr);
      print(map);
    } else {
      CustomToast.errorToast(message: 'Balance fetching issue');
      return null;
    }
  }
  Future<void> approvalTokenToSwap({
    required SwapableCoin from,
    required SwapableCoin to,
    required double firstAmount,
    required double secondAmount,
    required List<String> path,
    bool enterSecond = false,
    bool getFee = true,
  }) async {
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };
    final http.Request request = http.Request(
      'POST',
      Uri.parse('${APIUtils.walletBaseURL}/swap/getAmountsOut'),
    );
    request.body = json.encode(<String, dynamic>{
      'user_id': LocalData.email(),
      'accounts': LocalData.privateKeyAddress(),
      'privateKey': LocalData.privateKey(),
      'amount1': firstAmount,
      'amount2': secondAmount,
      'path': path,
      'enterSecondAmount': enterSecond,
      'firstSymbol': from.symbol.trim().toUpperCase(),
      'secondSymbol': to.symbol.trim().toUpperCase(),
      'firstContractAddress': from.contractAddress.trim(),
      'secondContractAddress': to.contractAddress.trim(),
      'getFee': false
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final String respStr = await response.stream.bytesToString();
      Map<String, dynamic> map = json.decode(respStr);
      print(map);
    } else {
      CustomToast.errorToast(message: 'Balance fetching issue');
      return null;
    }
  }
}
