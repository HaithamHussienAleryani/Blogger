import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blogger'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                context.goNamed('addBlog');
              },
              icon: const Icon(
                CupertinoIcons.add_circled,
                color: Colors.grey,
              )),
        ],
      ),
    );
  }
}
