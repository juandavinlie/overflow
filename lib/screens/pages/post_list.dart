import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:overflow/models/post.dart';
import 'package:overflow/models/user.dart';
import 'package:overflow/screens/pages/post_card.dart';
import 'package:overflow/screens/pages/post_details.dart';
import 'package:overflow/screens/shared/constants.dart';
import 'package:overflow/screens/shared/loading.dart';
import 'package:provider/provider.dart';

class PostList extends StatefulWidget {
  Function loadOlderPosts;
  Function loadNewerPosts;
  Function stopLoadingNewPosts;
  ScrollController scrollController;

  PostList({this.loadOlderPosts, this.loadNewerPosts, this.stopLoadingNewPosts, this.scrollController});

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<Post>>(context);
    final user = Provider.of<User>(context);
    return posts == null
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.loadOlderPosts(posts[0].time.millisecondsSinceEpoch);
                    },
                    icon: Icon(Icons.add),
                    label: Text("Extend")),
                FlatButton.icon(
                    onPressed: () {
                      widget.loadNewerPosts();
                    },
                    icon: Icon(Icons.refresh),
                    label: Text("Refresh"))
              ],
            ),
            body: ListView.builder(
              controller: widget.scrollController,
              scrollDirection: Axis.vertical,
              itemCount: posts.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  firstLoadedPostTime = posts[index].time.millisecondsSinceEpoch;
                }
                if (index == posts.length - 1) {
                  lastLoadedPostTime = posts[index].time.millisecondsSinceEpoch;
                }
                numberOfLoadedPosts = posts.length;
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
