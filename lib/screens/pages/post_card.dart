import 'package:flutter/material.dart';
import 'package:overflow/models/post.dart';
import 'package:overflow/screens/shared/constants.dart';
import 'package:overflow/services/database.dart';

class PostCard extends StatefulWidget {
  final Post post;
  final bool isDeletable;

  PostCard({this.post, this.isDeletable});

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.fromLTRB(15, 12, 15, 0),
      child: Padding(
        padding: EdgeInsets.fromLTRB(7, 12, 7, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/squidward.jpg'),
                      radius: 25,
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.post.creator.username,
                          style: TextStyle(
                            color: Colors.grey[850],
                            letterSpacing: 2,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          widget.post.time.substring(0,16),
                          style: TextStyle(
                            color: Colors.grey[600],
                            letterSpacing: 2,
                            fontSize: 10,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          widget.post.creator.country,
                          style: TextStyle(
                            letterSpacing: 2,
                            fontSize: 6,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(child: SizedBox()),
                Delete(showDelete: widget.isDeletable, post: widget.post),
              ],
            ),
            Column(
              children: [
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Container(
                    width: screenWidth(context),
                    child: Text(
                      widget.post.content,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.2,
                      ),
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Delete extends StatefulWidget {
  bool showDelete;
  Post post;

  Delete({this.showDelete, this.post});

  @override
  _DeleteState createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  @override
  Widget build(BuildContext context) {
    return widget.showDelete
        ? IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
            onPressed: () async {
              await DatabaseService(uid: widget.post.creator.uid).deletePost(widget.post.postId);
            },
            icon: Icon(Icons.delete),
            iconSize: 20,
            alignment: Alignment.topRight,
            color: Colors.grey[700],
          )
        : SizedBox();
  }
}
