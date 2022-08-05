import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/app_user.dart';
import '../utilities/api_utils.dart';
import '../widget/custom_widgets/custom_toast.dart';
import 'local_data.dart';

class AuthAPI {
  Future<AppUser?> login({
    required String email,
    required String password,
  }) async {
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };
    final http.Request request =
        http.Request('POST', Uri.parse('${APIUtils.walletBaseURL}/auth/login'));
    request.body = json.encode(
      <String, String>{
        'email': email.trim(),
        'password': password.trim(),
      },
    );
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final String respStr = await response.stream.bytesToString();
      final AppUser user = AppUser.fromJson(respStr);
      LocalData.setEmailKey(email.trim());
      LocalData.setPasswordKey(password.trim());
      return user;
    } else {
      final String respStr = await response.stream.bytesToString();
      Map<String, dynamic> mapp = json.decode(respStr);
      CustomToast.errorToast(message: mapp['message'] ?? 'Error while login');
      return null;
    }
  }

  Future<bool> signup({
    required String email,
    required String password,
    required String username,
  }) async {
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };
    final http.Request request = http.Request(
        'POST', Uri.parse('${APIUtils.walletBaseURL}/auth/signup'));
    request.body = json.encode(<String, dynamic>{
      'email': email.trim(),
      'password': password.trim(),
      'user_name': username.trim(),
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final String respStr = await response.stream.bytesToString();
    Map<String, dynamic> mapp = json.decode(respStr);
    if (response.statusCode == 200) {
      print('done');
      LocalData.setEmailKey(email);
      LocalData.setAccoountID(mapp['data']['id']);
      return true;
    } else {
      CustomToast.errorToast(message: mapp['message'] ?? 'Error while login');
      return false;
    }
  }
}
