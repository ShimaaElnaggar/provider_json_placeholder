import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_json_placeholder/provider/comments_provider.dart';
import 'package:provider_json_placeholder/provider/posts_provider.dart';
import 'package:provider_json_placeholder/views/posts_view.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
      ChangeNotifierProvider<PostsProvider>(
      create: (context) => PostsProvider(),),
          ChangeNotifierProvider<CommentsProvider>(
            create: (context) => CommentsProvider(),),
        ],
            child: const MyApp()),
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PostsView(),
    );
  }
}


