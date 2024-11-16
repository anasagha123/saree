import 'package:dio/dio.dart';

class MyHttpClient {
  static const String apiRoute = "";
  static Map<String, dynamic> headers = {};
  static Dio dio = Dio(BaseOptions(
    baseUrl: apiRoute,
    headers: headers,
  ));

  static Future<Response> getData({
    required String path,
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> data = const {},
  }) =>
      dio.get(path, queryParameters: queryParameters, data: data);

  static Future<Response> postData({
    required String path,
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> data = const {},
  }) =>
      dio.post(path, queryParameters: queryParameters, data: data);

  static Future<Response> deleteData({
    required String path,
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> data = const {},
  }) =>
      dio.delete(path, queryParameters: queryParameters, data: data);

  static Future<Response> putData({
    required String path,
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> data = const {},
  }) =>
      dio.put(path, queryParameters: queryParameters, data: data);
}

class MyEndPoints {}
