import 'package:flutter/material.dart';
import 'package:overflow/models/post.dart';

class PostDetail extends StatefulWidget {

  final Post post;

  PostDetail({ this.post });

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text(widget.post.content),
    );
  }
}