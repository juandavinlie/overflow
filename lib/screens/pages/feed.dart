// import 'dart:html/';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:overflow/models/post.dart';
import 'package:overflow/models/user.dart';
import 'package:overflow/screens/pages/post_list.dart';
import 'package:overflow/services/database.dart';
import 'package:provider/provider.dart';
import 'package:overflow/models/localuser.dart';
import 'package:overflow/screens/shared/new_post.dart';

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
        backgroundColor: Colors.white,
        body: PostList(),
        floatingActionButton: FloatingActionButton(
          elevation: 3,
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return StreamProvider<LocalUser>.value(
                      value: DatabaseService(uid: user.uid).localUser,
                      child: NewPost());
                });
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
