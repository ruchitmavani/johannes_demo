import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:phone_form_field/phone_form_field.dart';

class CountryCodeHelper {
  factory CountryCodeHelper() {
    return _singleton;
  }

  CountryCodeHelper._internal();

  static final CountryCodeHelper _singleton = CountryCodeHelper._internal();
  static IsoCode code = IsoCode.DE;

  static Future<void> getIsoCode() async {
    const url = 'http://ip-api.com/json';
    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body) as Map?;
        if (data == null) {
          return;
        }
        if (data['status'] == 'success') {
          code = IsoCode.fromJson(data['countryCode'].toString());
        }
      }
    } catch (e) {
      //do nothing Germany will be default country code
    }
  }
}
