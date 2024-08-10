import 'dart:convert';
import 'package:provider_json_placeholder/models/call_result.dart';
import 'package:provider_json_placeholder/repository/call_repository.dart';
import 'package:provider_json_placeholder/services/dio_services.dart';

class CommentsRepository extends CallRepository {
  @override
  Future<CallResult> delete(String id, [Map<String, dynamic>? args]) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<CallResult> get([Map<String, dynamic>? args]) async {
    try {
      var response =
          await DioServices.dio.get('posts/${args!['postId']}/comments');
      if ((response.statusCode ?? 0) >= 200 &&
          (response.statusCode ?? 0) < 299) {
        return CallResult(
            status: response.statusCode!,
            statusMessage: response.statusMessage!,
            data: json.decode(response.data),
            isSuccess: true,
            error: '');
      } else {
        return CallResult(
            isSuccess: false,
            status: response.statusCode!,
            statusMessage: response.statusMessage!,
            data: null,
            error: 'Error : ${response.statusCode}');
      }
    } catch (e) {
      return CallResult(
          status: 500,
          statusMessage: '',
          data: null,
          error: '$e',
          isSuccess: false);
    }
  }

  @override
  Future<CallResult> patch(String id, Map<String, dynamic> data,
      [Map<String, dynamic>? args]) {
    // TODO: implement patch
    throw UnimplementedError();
  }

  @override
  Future<CallResult> post(Map<String, dynamic> data,
      [Map<String, dynamic>? args]) {
    // TODO: implement post
    throw UnimplementedError();
  }

  @override
  Future<CallResult> put(String id, Map<String, dynamic> data,
      [Map<String, dynamic>? args]) {
    // TODO: implement put
    throw UnimplementedError();
  }
}
