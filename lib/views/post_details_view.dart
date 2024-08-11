import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_json_placeholder/models/post.dart';
import 'package:provider_json_placeholder/provider/comments_provider.dart';

class CommentsView extends StatefulWidget {
  final Post post;
  const CommentsView({required this.post, super.key});

  @override
  State<CommentsView> createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {
  bool isExpanded = false;
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    Provider.of<CommentsProvider>(context, listen: false)
        .fetchComments(widget.post.id);
    isExpanded = false;
    setState(() {});
    await Future.delayed(const Duration(milliseconds: 300));

    isExpanded = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: Text('Post ${widget.post.id.toString()}'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            AnimatedContainer(
              height: isExpanded ? 180 : 0,
              duration: const Duration(milliseconds: 400),
              child: SingleChildScrollView(
                child: PhysicalModel(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.post.title,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 10),
                          Text(widget.post.body,
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54)),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.blue.shade100,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                widget.post.userId.toString(),
                                style: TextStyle(color: Colors.purple.shade200),
                              )
                            ],
                          )

                          // post details
                        ],
                      ),
                    )),
              ),
            ),
            const SizedBox(height: 15),
            const Text('  Comments:',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            const SizedBox(height: 5),
            Consumer<CommentsProvider>(
              builder: (context, commentsProvider, _) {
                if (commentsProvider.comments.isEmpty) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.blue.shade200,
                  ));
                }
                return ListView.builder(
                  itemCount: commentsProvider.comments.length,
                  itemBuilder: (context, index) {
                    final comment = commentsProvider.comments[index];

                    return Card(
                      color: Colors.blue.shade50,
                      surfaceTintColor: Colors.white,
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            comment.body,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            comment.email,
                            style: TextStyle(color: Colors.blue.shade200),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
