import 'package:flutter/material.dart';
import 'package:provider_json_placeholder/models/post.dart';

import 'package:provider_json_placeholder/repository/post_repository.dart';

class PostsProvider extends ChangeNotifier {
  List<Post> posts = [];

  Future<void> fetchPosts() async {
    var postRepository = PostRepository();

    var callResult = await postRepository.get();

    if (callResult.isSuccess) {
      if (callResult.data != null && callResult.data is List) {
        posts = (callResult.data as List).map((postJson) => Post.fromJson(postJson)).toList();
      } else {
        print('Error fetching posts: Data format is not as expected');
      }
    } else {
      print('Error fetching posts: ${callResult.error}');
    }

    notifyListeners();
  }
}