import 'package:dio/dio.dart';

abstract class HttpMethods {
  static const String get = 'GET';
  static const String post = 'POST';
  static const String put = 'PUT';
  static const String delete = 'DELETE';
  static const String patch = 'PATCH';
}

class HTTPManager {
  Future<Map> restRequest({
    required String url,
    required String method,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  }) async {
    // Request Headers
    final defaultHeaders = headers?.cast<String, String>() ?? {}..addAll({
      'content-type': 'application/json',
      'accept': 'application/json',
      'X-Parse-Application-Id': 'wK7GcEjr2V4br5q5mlR1kybQ5dvxMFDX0qtE1d6Y',
      'X-Parse-REST-API-Key': '2kahi62fkWePLWAwC7k8aMrtQkobogcgkruMxbeB',
    });

    final Dio dio = Dio();

    try {
      Response response = await dio.request(
      url,
      options: Options(
        headers: defaultHeaders,
        method: method,
      ),
      data: body,
    );

    return response.data; 
    } on DioException catch (error) {
      return error.response?.data ?? {};
    } catch (error) {

      // Retorno de map vazio
      return {};
    }
  }
}
