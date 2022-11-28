import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiCaller {
  static const String _apiKey = '5e41b4874c06db3c123fefdab9ccdbe6';
  static const String _apiKeyM = 'abab944243f6c20a72a1ec32cd834be3';
  static const String _baseUrl = 'https://financialmodelingprep.com/api/v3/';

  static Future<List?> sendGetRequest(String endPoint) async {
    List? result;
    await http
        .get(Uri.parse('$_baseUrl$endPoint/?apikey=$_apiKey'))
        .then((res) {
      // print(res.body);
      result = json.decode(res.body) as List;
    });
    // print('result --> $result\n');
    // result = [{}, {}, {}, {}, {}];
    return result;
  }

  // static Future<List?> sendGetSheetRequest(String endPoint) async {
  //   List? result;
  //   await http
  //       .get(Uri.parse('$_baseUrl$endPoint/?apikey=$_apiKeyM'))
  //       .then((res) {
  //     result = json.decode(res.body) as List;
  //   });
  //   return result;
  // }

}
