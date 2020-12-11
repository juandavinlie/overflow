// import 'dart:html/';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:overflow/models/post.dart';
import 'package:overflow/models/user.dart';
import 'package:overflow/screens/pages/universal_post_list.dart';
import 'package:overflow/services/database.dart';
import 'package:provider/provider.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);


    return StreamProvider<List<Post>>.value(
      value: DatabaseService(uid: user.uid).universalPosts,
      child: Scaffold(
        backgroundColor: Colors.orange[50],
        body: UniversalPostList()
      ),
    );
  }
}
