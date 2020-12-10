import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
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
                  'louisdavinlie'.toUpperCase(),
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
                    "Paul who wrote he was debtor to the Greeks also wrote he was not ashamed of the gospel. The gospel tells us that we are born as sinners who need to be saved. This happens when people repent of their sins and believe that the Lord Jesus, God's only begotten Son, took away our sins on the cross. Once people are born again as children of God (John 3 verse 3, Romans 8 verses 14 to 17) they have everlasting life and know the Lord Jesus as Saviour and Lord as well as knowing the Father ( John 3 verse 16, 17 verse 3). Knowing the Lord Jesus as Saviour also means that they are saved from their sins and its power Matthew 1 vers 21).",
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
