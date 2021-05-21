import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sample_app/services/database.dart';

import '../models/post.dart';
import '../widgets/post_list.dart';
import '../widgets/text_input_widget.dart';

class MyHomePage extends StatefulWidget {
  final FirebaseUser user;

  MyHomePage(this.user);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    updatePosts();
  }

  void newPost(String text) {
    var post = new Post(text, widget.user.displayName);
    post.setId(savePost(post));
    this.setState(() {
      this.posts.add(post);
    });
  }

  void updatePosts() {
    getAllPosts().then((posts) => this.setState(() {
          this.posts = posts;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Poster'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(child: PostList(this.posts, widget.user)),
            TextInputWidget(this.newPost),
          ],
        ),
      ),
    );
  }
}
