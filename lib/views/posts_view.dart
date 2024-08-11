import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_json_placeholder/provider/posts_provider.dart';
import 'package:provider_json_placeholder/views/post_details_view.dart';

class PostsView extends StatefulWidget {
  const PostsView({super.key});

  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {
  int selectedCardIndex = -1;
  @override
  void initState() {
    Provider.of<PostsProvider>(context, listen: false).fetchPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: const Center(child: Text(' Posts ')),
      ),
      body: Consumer<PostsProvider>(
        builder: (context, postsProvider, _) {
          if (postsProvider.posts.isEmpty) {
            return Center(child: CircularProgressIndicator(color: Colors.blue.shade200,));
          }
          return ListView.builder(
            itemCount: postsProvider.posts.length,
            itemBuilder: (context, index) {
              final post = postsProvider.posts[index];

              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Card(
                  color: selectedCardIndex == index
                      ? Colors.blue.shade200
                      : Colors.white,
                  surfaceTintColor: Colors.white,
                  shadowColor: Colors.black,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(post.title,style: const TextStyle(fontWeight: FontWeight.w700),),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(post.body,style: const TextStyle(fontWeight: FontWeight.w700,color: Colors.black54)),
                    ),
                    onTap: () {
                      setState(() {
                        selectedCardIndex = index;
                      });
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>  CommentsView(post: postsProvider.posts[index],)));
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
