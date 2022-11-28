import 'package:untitled1/api_caller.dart';

class ApiCollection {
  static Future<List> getAllCompanies() async {
    List companies = [];

    await ApiCaller.sendGetRequest('available-traded/list').then((response) {
      companies = [...response as List];
    });
    // print(companies);
    return companies.getRange(0, 20).toList();
  }

  static Future<Map> getBalanceSheetData(String symbol) async {
    Map<dynamic, dynamic> sheet = {};
    print(symbol);
    await ApiCaller.sendGetRequest('balance-sheet-statement/$symbol')
        .then((value) {
      List sheets = [...value as List];
      print('sheets --> ${sheets}');
      sheet = sheets[0] as Map;
    });
    print(sheet);
    return sheet;
  }
}
