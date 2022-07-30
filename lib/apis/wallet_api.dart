import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/seed_phrase.dart';
import '../utilities/api_utils.dart';
import '../widget/custom_widgets/custom_toast.dart';
import 'api_request_error.dart';
import 'local_data.dart';

class WalletAPI {
  Future<SeedPhrase?> getSeedPhrase() async {
    final http.Request request = http.Request(
      'GET',
      Uri.parse(
        '${APIUtils.walletBaseURL}/wallet/seedPharse',
      ),
    );
    final http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final String respStr = await response.stream.bytesToString();
      final SeedPhrase seedPhrase = SeedPhrase.fromJson(respStr);
      return seedPhrase;
    } else {
      APIRequestError.martketplace(response.statusCode);
      return null;
    }
  }

  Future<bool> generatePrivateKey({required String phrase}) async {
    print('Phrase: $phrase');
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };
    final http.Request request = http.Request('POST',
        Uri.parse('${APIUtils.walletBaseURL}/wallet/generatePrivateKey'));
    request.body = json.encode(<String, String>{'mnemonic': phrase.trim()});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final String respStr = await response.stream.bytesToString();
      Map<String, dynamic> mapp = json.decode(respStr);
      await LocalData.setPrivateKey(mapp['privateKey']);
      await LocalData.setPrivateKeyAddress(mapp['address']);
      return true;
    } else {
      CustomToast.errorToast(message: 'Facing errors while fetching Key');
      return false;
    }
  }

  Future<bool> importPrivateKey({required String privateKey}) async {
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };
    final http.Request request = http.Request(
        'POST', Uri.parse('${APIUtils.walletBaseURL}/wallet/importPrivateKey'));
    request.body = json.encode(<String, String>{'private_key': privateKey});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final String respStr = await response.stream.bytesToString();
      Map<String, dynamic> mapp = json.decode(respStr);
      LocalData.setPrivateKey(mapp['privateKey']);
      LocalData.setPrivateKeyAddress(mapp['address']);
      return true;
    } else {
      CustomToast.errorToast(message: 'Facing errors while fetching Key');
      return false;
    }
  }

  Future<double> balance() async {
    final String? address = LocalData.privateKeyAddress();
    print(address);
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };
    final http.Request request = http.Request(
        'POST', Uri.parse('${APIUtils.walletBaseURL}/dashboard/getBalance'));
    request.body = json.encode(<String, dynamic>{
      'accounts': address ?? '',
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final String respStr = await response.stream.bytesToString();
      Map<String, dynamic> mapp = json.decode(respStr);
      return double.parse(mapp['balance']);
    } else {
      return 0;
    }
  }
}
