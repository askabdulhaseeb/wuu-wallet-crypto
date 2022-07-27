import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utilities/api_utils.dart';
import 'local_data.dart';

class HomeAPI {
  Future<double> balance() async {
    final String? _address = LocalData.privateKeyAddress();
    print(_address);
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };
    final http.Request request = http.Request(
        'POST', Uri.parse('${APIUtils.walletBaseURL}/home/getBalance'));
    request.body = json.encode(<String, dynamic>{
      'accounts': _address ?? '',
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final String respStr = await response.stream.bytesToString();
      Map<String, dynamic> mapp = json.decode(respStr);
      return double.parse(mapp['balace']);
    } else {
      return 0;
    }
  }
}
