import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:overflow/models/post.dart';
import 'package:overflow/models/user.dart';
import 'package:overflow/screens/pages/post_card.dart';
import 'package:overflow/screens/shared/loading.dart';
import 'package:provider/provider.dart';

class UniversalPostList extends StatefulWidget {
  @override
  _UniversalPostListState createState() => _UniversalPostListState();
}

class _UniversalPostListState extends State<UniversalPostList> {
  @override
  Widget build(BuildContext context) {

    final posts = Provider.of<List<Post>>(context);

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostCard(post: posts[index], isDeletable: true,);
      },
    );
  }
}