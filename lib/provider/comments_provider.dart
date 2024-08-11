import 'package:flutter/material.dart';
import 'package:provider_json_placeholder/models/comment.dart';
import 'package:provider_json_placeholder/repository/comment_repository.dart';

class CommentsProvider extends ChangeNotifier {
  List<Comment> comments = [];

  Future<void> fetchComments(int id) async {
    var commentsRepository = CommentsRepository();

    var callResult = await commentsRepository.get();

    if (callResult.isSuccess) {
      if (callResult.data != null && callResult.data is List) {
        comments = (callResult.data as List)
            .map((commentJson) => Comment.fromJson(commentJson))
            .toList();
      } else {
        print('Error fetching comments: Data format is not as expected');
      }
    } else {
      print('Error fetching comments: ${callResult.error}');
    }

    notifyListeners();
  }
}
