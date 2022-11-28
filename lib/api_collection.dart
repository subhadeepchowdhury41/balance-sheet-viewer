import 'package:untitled1/api_caller.dart';

class ApiCollection {
  static Future<List> getAllCompanies() async {
    List companies = [];

    await ApiCaller.sendGetRequest('available-traded/list').then((response) {
      companies = [...response as List];
    });
    // print(companies.length);
    return companies;
  }

  static Future<List> getBalanceSheets(String symbol) async {
    List sheets = [];
    // print(symbol);
    await ApiCaller.sendGetRequest('balance-sheet-statement/$symbol')
        .then((value) {
      // print(value);
      sheets = [...value as List];
      // print(sheets);
    });
    return sheets;
  }
}
