import 'package:dio/dio.dart';

class HttpUtils {
  static Dio _dio;

  static get dio {
    if (_dio == null) {
      BaseOptions options = BaseOptions(
        baseUrl: "http://192.168.201.1:3000",
      );

      _dio = Dio(options);

      dio.interceptors.add(InterceptorsWrapper(
        onRequest:(RequestOptions options) async {
          // 在请求被发送之前做一些事情
          return options;
        },
        onResponse:(Response response) async {
          // 在返回响应数据之前做一些预处理
          return response;
        },
        onError: (DioError e) async {
          // 当请求失败时做一些预处理
          return e;
        }
      ));
    }
    return _dio;
  }
}

