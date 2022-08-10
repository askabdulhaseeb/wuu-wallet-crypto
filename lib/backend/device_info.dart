import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:muuwallet/helpers/strings.dart';

abstract class BaseDeviceInfo {
  getDeviceIp();
}

class DeviceInfoFxn implements BaseDeviceInfo {
  @override
  Future<Map<String, dynamic>>? getDeviceIp() async {
    Map<String, dynamic>? dats;
    try {
      String? deviceName = await _getDeviceInfo();
      Map<String, dynamic>? deviceIp = await _getIp();

      deviceIp![DEVICENAME] = deviceName;
      dats = deviceIp;
      return dats;
    } catch (e) {
      print(e);
    }
    return dats!;
  }

  Future<String?> _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? deviceName;
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo? androidInfo = await deviceInfo.androidInfo;

        deviceName = androidInfo.model;
        return deviceName;
      }
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

      deviceName = iosInfo.name;
      return deviceName;
    } catch (e) {
      print(e);
    }
    return deviceName;
  }

  Future<Map<String, dynamic>>? _getIp() async {
    Map<String, dynamic>? dts;

    String? ipGeoKey = dotenv.env['IP_GEOLOCATION_KEY'];

    String url = 'https://api.ipgeolocation.io/ipgeo?apiKey=$ipGeoKey';
    try {
      http.Response response = await http.get((Uri.parse(url)));
      var data = jsonDecode(response.body);
      dts = {
        IP: data['ip'],
        LOCATION: data['district'] + ', ' + data['city'],
        COUNTRY: data['country_name'],
      };
      return dts;
    } catch (e) {
      print(e);
    }
    return dts!;
  }
}
