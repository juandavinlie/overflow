import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:overflow/models/post.dart';
import 'package:overflow/models/user.dart';
import 'package:overflow/screens/pages/post_card.dart';
import 'package:overflow/screens/pages/post_details.dart';
import 'package:overflow/screens/shared/constants.dart';
import 'package:overflow/screens/shared/loading.dart';
import 'package:overflow/services/database.dart';
import 'package:provider/provider.dart';
import 'package:reference_parser/reference_parser.dart';

class UniversalPostList extends StatefulWidget {
  Function loadOlderPosts;
  Function loadNewerPosts;
  Function stopLoadingNewPosts;
  ScrollController scrollController;

  UniversalPostList(
      {this.loadOlderPosts,
      this.loadNewerPosts,
      this.stopLoadingNewPosts,
      this.scrollController});

  @override
  _UniversalPostListState createState() => _UniversalPostListState();
}

class _UniversalPostListState extends State<UniversalPostList> {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<Post>>(context);
    final user = Provider.of<User>(context);
    return posts == null
        ? Loading()
        : RefreshIndicator(
            onRefresh: () {
              return Future.delayed(Duration(milliseconds: 100));
            },
            child: ListView.builder(
              controller: widget.scrollController,
              scrollDirection: Axis.vertical,
              itemCount: posts.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  firstLoadedPostTime =
                      posts[index].time.millisecondsSinceEpoch;
                }
                lastLoadedPostTime = lastLoadedPostTime == null
                    ? posts[index].time.millisecondsSinceEpoch
                    : posts[index].time.millisecondsSinceEpoch <
                            lastLoadedPostTime
                        ? posts[index].time.millisecondsSinceEpoch
                        : lastLoadedPostTime;
                numberOfLoadedPosts = index + 1;
                return PostCard(
                  post: posts[index],
                  isDeletable: posts[index].creator.uid == user.uid,
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PostDetail(post: posts[index])));
                  },
                );
              },
            ),
          );
  }
}
