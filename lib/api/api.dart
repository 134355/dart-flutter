import 'package:dio/dio.dart';

import 'http_utils.dart';

class AppApi {
  static getconfig() async {
    try {
      Response response = await HttpUtils.dio.get('/test');
      print(response);
      return response;
    } catch(error) {
      print(error);
    }
  }
}

