import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiCaller {
  static const String _apiKey = '5e41b4874c06db3c123fefdab9ccdbe6';
  static const String _baseUrl = 'https://financialmodelingprep.com/api/v3/';

  static Future<List?> sendGetRequest(String endPoint) async {
    List? result;
    await http.get(Uri.parse('$_baseUrl$endPoint/?apikey=$_apiKey')).then((res) {
      result = json.decode(res.body) as List;
    });
    return result;
  }
}