// import 'dart:html/';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:overflow/models/post.dart';
import 'package:overflow/models/user.dart';
import 'package:overflow/screens/pages/universal_post_list.dart';
import 'package:overflow/screens/shared/constants.dart';
import 'package:overflow/services/auth.dart';
import 'package:overflow/services/database.dart';
import 'package:provider/provider.dart';
import 'package:overflow/models/localuser.dart';
import 'package:overflow/screens/shared/new_post.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  static int limit = 10;
  Stream<List<Post>> univPosts = DatabaseService().universalPostsFromStart(limit);
  ScrollController _feedScrollController = ScrollController();

  // load newer posts until last loaded post
  Future<void> _loadNewerPosts() {
    print(lastLoadedPostTime);
    setState(() {
      univPosts = DatabaseService().universalPostsFromStartToLastLoadedPost(lastLoadedPostTime);
    });
    return Future.delayed(Duration(milliseconds: 100));
  }

  // // load older posts, starting from most recent post
  // void _stopLoadingNewPosts() {
  //   setState(() {
  //     limit = numberOfLoadedPosts;
  //     univPosts = DatabaseService().nextUniversalPostsWithoutNew(firstLoadedPostTime, numberOfLoadedPosts);
  //   });
  // }
  
  // load older posts, starting from most recent post
  void _loadOlderPosts(int timeCreated) {
    setState(() {
      limit += 5;
      univPosts = DatabaseService().nextUniversalPostsWithoutNew(timeCreated, limit);
    });
  }

  @override
  void initState() {
    _feedScrollController.addListener(() {
      double nextView = _feedScrollController.offset;
      if (_feedScrollController.position.maxScrollExtent ==
          _feedScrollController.offset) {
        _loadOlderPosts(firstLoadedPostTime);
        _feedScrollController.animateTo(nextView + 110, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamProvider<List<Post>>.value(
      value: DatabaseService(uid: user.uid).universalPosts,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: UniversalPostList(loadOlderPosts: _loadOlderPosts, loadNewerPosts: _loadNewerPosts, scrollController: _feedScrollController,),
        floatingActionButton: FloatingActionButton(
          elevation: 3,
          onPressed: () {
            Navigator.push(
              context,
              SlideRightRoute(
                  page: StreamProvider<LocalUser>.value(
                      value: DatabaseService(uid: user.uid).localUser,
                      child: NewPost(loadNewerPost: _loadNewerPosts, feedScrollController: _feedScrollController,))),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
