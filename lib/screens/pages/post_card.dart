import 'package:flutter/material.dart';
import 'package:overflow/models/post.dart';

class PostCard extends StatefulWidget {

  final Post post;

  PostCard({ this.post });


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
      margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Padding(
        padding: EdgeInsets.fromLTRB(7, 15, 7, 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                SizedBox(height: 20),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/squidward.jpg'),
                  radius: 45,
                ),
                SizedBox(height: 30),
                Text(
                  widget.post.username.substring(0,5),
                  style: TextStyle(
                    color: Colors.grey[850],
                    letterSpacing: 2,
                    fontSize: 10,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Jakarta, Indonesia'.toUpperCase(),
                  style: TextStyle(
                    letterSpacing: 2,
                    fontSize: 6,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: screenWidth(context) - 200,
                  child: Text(
                    'A Debtor To Mercy Alone',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: screenWidth(context) - 200,
                  child: Text(
                    widget.post.content,
                    style: TextStyle(
                      fontSize: 10,
                      height: 1.2,
                    ),
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.justify,
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
