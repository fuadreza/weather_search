import 'dart:convert';

import 'package:dio/dio.dart';

class DioHelper {
  final String url;

  DioHelper(this.url);

  Future<dynamic> getData() async {
    try {
      Response response = await Dio().get(url);

      if (response.statusCode == 200) {
        var data = response.data;

        return data;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
}
