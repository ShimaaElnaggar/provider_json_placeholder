import 'package:dio/dio.dart';

abstract class DioServices {
  static final _baseOptions =
      BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com/');
  static final Dio dio = Dio(_baseOptions);
}
