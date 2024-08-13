import 'package:flutter/material.dart';
import 'package:provider_json_placeholder/models/comment.dart';
import 'package:provider_json_placeholder/repository/comment_repository.dart';

class CommentsProvider extends ChangeNotifier {
  List<Comment> comments = [];

  Future<void> fetchComments(int postId) async {
    var commentsRepository = CommentsRepository();

    var callResult = await commentsRepository.get({'postId': postId});
    // print('API Response - Status: ${callResult.status}, Message: ${callResult.statusMessage}, Data: ${callResult.data}');
    if (callResult.isSuccess) {
      if (callResult.data != null && callResult.data is List) {
        List<Comment> allComments = (callResult.data as List)
            .map((commentJson) => Comment.fromJson(commentJson))
            .toList();

        comments =
            allComments.where((comment) => comment.postId == postId).toList();
      } else {
        if (callResult.status == 500) {
          print(
              'Error fetching comments: Internal server error. Please try again later.');
        } else {
          print('Error fetching comments: ${callResult.error}');
        }
      }
    }
    notifyListeners();
  }
}
