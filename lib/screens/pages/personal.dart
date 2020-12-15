import 'package:flutter/material.dart';
import 'package:overflow/models/post.dart';
import 'package:overflow/models/user.dart';
import 'package:overflow/screens/pages/profile.dart';
import 'package:overflow/screens/pages/post_list.dart';
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
        backgroundColor: Colors.orange[50],
        body: Column(
          children: [
            Profile(),
            Divider(
              height: 0,
              thickness: 1,
              indent: 15,
              endIndent: 15,
            ),
            Expanded(
              child: UniversalPostList(),
            ),
          ],
        ),
      ),
    );
  }
}
