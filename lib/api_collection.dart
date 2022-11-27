import 'package:untitled1/api_caller.dart';

class ApiCollection {
  static Future<List> getAllCompanies() async {
    List companies = [];
    await ApiCaller.sendGetRequest('available-traded/list').then((response) {
      companies = [...response as List];
    });
    return companies.getRange(0, 10).toList();
  }
}