import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overflow/models/post.dart';
import 'package:overflow/models/user.dart';
import 'package:overflow/screens/shared/constants.dart';
import 'package:overflow/services/database.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final Post post;
  final bool isDeletable;

  PostCard({this.post, this.isDeletable});

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(10),
      // ),
      // margin: EdgeInsets.fromLTRB(15, 12, 15, 0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
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
                              style: GoogleFonts.lato(
                                color: Colors.grey[850],
                                letterSpacing: 2,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              widget.post.time.toString(),
                              style: GoogleFonts.lato(
                                color: Colors.grey[600],
                                letterSpacing: 2,
                                fontSize: 10,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              widget.post.creator.country,
                              style: GoogleFonts.lato(
                                letterSpacing: 2,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(child: SizedBox()),
                    Delete(
                        showDelete: widget.isDeletable,
                        post: widget.post,
                        liked: widget.post.liked),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Container(
                        width: size.width,
                        child: Text(
                          widget.post.content,
                          style: GoogleFonts.lato(
                            fontSize: 15,
                            height: 1.2,
                          ),
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          Divider(
            color: Colors.black,
            thickness: 0.3,
          ),
        ],
      ),
    );
  }
}

class Delete extends StatefulWidget {
  bool showDelete;
  Post post;
  bool liked;

  Delete({this.showDelete, this.post, this.liked});

  @override
  _DeleteState createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return widget.showDelete
        ? IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () async {
              await DatabaseService(uid: widget.post.creator.uid)
                  .deletePost(widget.post.postId);
            },
            icon: Icon(Icons.delete),
            iconSize: 20,
            alignment: Alignment.topRight,
            color: Colors.grey[700],
          )
        : IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () async {
              setState(() {
                widget.liked = !widget.liked;
              });
              if (widget.liked) {
                await DatabaseService(uid: widget.post.creator.uid)
                    .addLikedBy(widget.post.postId, user.uid);
              } else {
                await DatabaseService(uid: widget.post.creator.uid)
                    .removeLikedBy(widget.post.postId, user.uid);
              }
            },
            icon: Icon(Icons.favorite),
            iconSize: 20,
            alignment: Alignment.topRight,
            color: widget.liked ? Colors.red : Colors.grey[700],
          );
  }
}
