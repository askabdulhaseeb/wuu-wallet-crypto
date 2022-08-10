import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../helpers/strings.dart';
import 'call_functions.dart';
import 'encrypt.dart';
import 'mysql/sql_activities.dart';

abstract class BaseWalletAd {
  Future<Map> createWallet();
  Future<Map> getWalletBalance(List walletIds);
  Future<Map> transferCoin(
      String walletId, String transferKey, String address, String amount);

  Future<String?> getFee(
      String walletId, String address, String amount, context);
  Future<List> getWalletHistory(String walletId);
}

class WalletAd implements BaseWalletAd {
  final CallFunctions _callFunctions = CallFunctions();
  final ActivitiesSql _activitiesSql = ActivitiesSql();

  static String myWalletId = '';
  static String url = 'https://apirone.com/api/v2/wallets';
  String reference = randomString(8).toString();

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
  };

  final EncryptApp _encryptApp = EncryptApp();

  List units = [
    BTC,
    DOGE,
  ];

  @override
  Future<Map> createWallet() async {
    final Map encryptedAddMap = {};
    String? endpointUrl = dotenv.env['ENDPOINT_URL'];

    for (String un in units) {
      Map<String, dynamic> body = {
        'type': 'saving',
        'currency': un,
        'callback': {
          'url': '${endpointUrl!}notifications-wallet.php',
        }
      };
      try {
        await http
            .post(Uri.parse(url),
                headers: requestHeaders, body: jsonEncode(body))
            .then((value) async {
          if (value.statusCode == 200) {
            var body = jsonDecode(value.body);
            String walletId = body[WALLET];
            String transferKey = body[TRANSFERKEY];

            String encryptedWalletId = _encryptApp.appEncrypt(walletId);
            String encryptedTrxKey = _encryptApp.appEncrypt(transferKey);

            try {
              http.Response? addressResponse = await http
                  .post(
                Uri.parse('$url/$walletId/addresses'),
                headers: requestHeaders,
              )
                  .then((value) {
                if (value.statusCode == 200) {
                  var body = jsonDecode(value.body);
                  String address = body[ADDRESS];
                  String encryptedAddress = _encryptApp.appEncrypt(address);

                  Map<String, dynamic> encryptedWalletData = {
                    '${un}_$TRANSFERKEY': encryptedTrxKey,
                    '${un}_$WALLETID': encryptedWalletId,
                    '${un}_$ADDRESS': encryptedAddress,
                  };
                  encryptedAddMap.addAll(encryptedWalletData);
                } else {
                  print('error');
                }
              }).timeout(
                const Duration(seconds: 60),
              );
              return addressResponse;
            } catch (e) {
              print(e);
            }
          }
        }).timeout(
          const Duration(seconds: 60),
        );
      } catch (e) {
        print(e);
      }
    }

    return encryptedAddMap;
  }

  @override
  Future<Map> getWalletBalance(List walletIds) async {
    Map balancesList = {};

    for (String walletId in walletIds) {
      String uni = walletId.substring(0, 3);
      String unit = uni == 'dog' ? DOGE : uni;
      try {
        await http
            .get(
                Uri.parse(
                  '$url/$walletId/balance',
                ),
                headers: requestHeaders)
            .then((value) {
          if (value.statusCode == 200) {
            var body = jsonDecode(value.body);
            double available = ((body[AVAILABLE]) / 100000000.00);
            double total = ((body[TOTAL]) / 100000000.00);

            Map<String, double> balance = {
              AVAILABLE: available,
              TOTAL: total,
            };

            balancesList[unit] = (balance[AVAILABLE]);
          }
        }).timeout(
          const Duration(seconds: 30),
        );
      } catch (e) {
        print(e);
      }
    }

    return balancesList;
  }

  @override
  Future<Map> transferCoin(
    String walletId,
    String transferKey,
    String address,
    String amount,
  ) async {
    Map result;

    Map<String, dynamic> trxnBody = {
      TRANSFERKEY: transferKey,
      DESTINATIONS: [
        {
          ADDRESS: address,
          AMOUNT: (double.tryParse(amount)! * 100000000).toInt()
        },
      ],
    };
    try {
      http.Response response = await http
          .post(Uri.parse('$url/$walletId/transfer'),
              headers: requestHeaders, body: jsonEncode(trxnBody))
          .timeout(
            const Duration(seconds: 30),
          );

      var body = jsonDecode(response.body);
      var status = response.statusCode;
      var txs = body['txs'];

      if (status == 200) {
        result = {
          STATUS: true,
          HASH: txs,
        };
        _activitiesSql.storeUserActivitiesSql(4);

        return result;
      } else {
        result = {
          STATUS: false,
          HASH: null,
        };

        return result;
      }
    } catch (e) {
      print(e);
      result = {
        STATUS: false,
        HASH: null,
      };

      return result;
    }
  }

  @override
  Future<List> getWalletHistory(String walletId) async {
    List transactionList = [];
    try {
      http.Response response = await http
          .get(
            Uri.parse('$url/$walletId/history?limit=20&offset=0'),
            headers: requestHeaders,
          )
          .timeout(
            const Duration(seconds: 30),
          );

      var body = jsonDecode(response.body);
      var status = response.statusCode;
      List itemList = body[ITEMS];
      if (status == 200) {
        for (int i = 0; i < itemList.length; i++) {
          double amount = itemList[i][AMOUNT];
          bool income = itemList[i][TYPE] == 'payment' ? false : true;
          String dateT = itemList[i][DATE];
          String date = dateT.substring(0, 10);
          Map history = {
            DATETIME: date,
            INCOME: income,
            AMOUNT: (amount.abs() / 100000000.00).toStringAsFixed(6),
            TITLE: income ? BOUGHT : SOLD,
            HASH: itemList[i][ID],
          };
          transactionList.add(history);
        }
        return transactionList;
      } else {
        print('error');
      }
    } catch (e) {
      print(e);
    }
    return transactionList;
  }

  @override
  Future<String?> getFee(
      String walletId, String address, String amount, context) async {
    String? totalFeee;
    try {
      http.Response response = await http
          .get(
            Uri.parse(
                '$url/$walletId/transfer?destinations=$address:$amount%25&fee=normal&subtract_fee_from_amount=true'),
            headers: requestHeaders,
          )
          .timeout(
            const Duration(seconds: 30),
          );

      var body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        double txsFee = body['fee']['network']['amount'];
        totalFeee = (txsFee / 100000000.00).toStringAsFixed(6);
      } else {
        _callFunctions.showSnacky(body[MESSAGE], false, context);
      }

      return totalFeee;
    } catch (e) {
      print(e);
    }
    return totalFeee;
  }
}
