import 'package:http/http.dart';
import 'package:csv/csv.dart';
import 'dart:core';
import 'dart:convert' show utf8;

int sc;

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;
  List<List<dynamic>> data = [];

  Future<List<List<dynamic>>> getData() async {
    sc = 0;
    final httpClient = new Client();
    Response response = await httpClient.get(url);
    if (response.statusCode == 200) {
      List<int> bodyBytes = response.bodyBytes;
      String responseBodyBytes = utf8.decode(bodyBytes, allowMalformed: true);
      data = CsvToListConverter(eol: '\n').convert(responseBodyBytes);
      sc = response.statusCode;
      return data;
    } else {
      sc = response.statusCode;
      return [];
    }
  }

  int getStatusCode() {
    return sc;
  }
}
