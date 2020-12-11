import 'package:flutter/material.dart';
import 'package:overflow/models/post.dart';
import 'package:overflow/models/user.dart';
import 'package:overflow/screens/pages/profile.dart';
import 'package:overflow/screens/pages/universal_post_list.dart';
import 'package:overflow/services/database.dart';
import 'package:provider/provider.dart';

class Personal extends StatefulWidget {
  @override
  _PersonalState createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamProvider<List<Post>>.value(
      value: DatabaseService(uid: user.uid).individualPosts,
      child: Scaffold(
        body: Column(
          children: [
            Profile(),
            Expanded(
              child: UniversalPostList(),
            )
          ],
        ),
      ),
    );
  }
}
