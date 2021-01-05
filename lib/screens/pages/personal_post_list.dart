import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:overflow/models/post.dart';
import 'package:overflow/models/user.dart';
import 'package:overflow/screens/pages/post_card.dart';
import 'package:overflow/screens/pages/post_details.dart';
import 'package:overflow/screens/shared/constants.dart';
import 'package:overflow/screens/shared/loading.dart';
import 'package:provider/provider.dart';

class PersonalPostList extends StatefulWidget {
  Function loadOlderPosts;
  Function loadNewerPosts;
  Function stopLoadingNewPosts;

  PersonalPostList(
      {this.loadOlderPosts,
      this.loadNewerPosts,
      this.stopLoadingNewPosts});

  @override
  _PersonalPostListState createState() => _PersonalPostListState();
}

class _PersonalPostListState extends State<PersonalPostList> {

  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<Post>>(context);
    final user = Provider.of<User>(context);
    return posts == null
        ? Loading()
        : RefreshIndicator(
            onRefresh: widget.loadNewerPosts,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: posts.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  firstPersonalLoadedPostTime =
                      posts[index].time.millisecondsSinceEpoch;
                }
                lastPersonalLoadedPostTime = lastPersonalLoadedPostTime == null ? posts[index].time.millisecondsSinceEpoch : posts[index].time.millisecondsSinceEpoch < lastPersonalLoadedPostTime ? posts[index].time.millisecondsSinceEpoch : lastPersonalLoadedPostTime;
                numberOfPersonalLoadedPosts = index + 1;
                return PostCard(
                    post: posts[index],
                    isDeletable: posts[index].creator.uid == user.uid,
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PostDetail(post: posts[index])));
                    });
              },
            ),
          );
  }
}
