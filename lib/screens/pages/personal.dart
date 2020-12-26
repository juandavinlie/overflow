import 'package:flutter/material.dart';
import 'package:overflow/models/localuser.dart';
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

    return Scaffold(
      backgroundColor: Colors.white,
      body:
          // CustomScrollView(
          //   slivers: [
          //     SliverAppBar(
          //       backgroundColor: Colors.white,
          //       expandedHeight: 250,
          //       floating: false,
          //       flexibleSpace: FlexibleSpaceBar(background: Profile(),),
          //     ),
          //     SliverList(
          //       delegate: SliverChildBuilderDelegate(
          //         (context, index) {
          //           return Container(
          //             height: 50,
          //             color: Colors.orange[100 * (index % 7)],
          //             child: Text('orange $index'),
          //           );
          //         },
          //         childCount: 30,
          //       ),
          //     )
          //   ],
          // )

          Column(
        children: [
          Profile(),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(50),
                  child: AppBar(
                    elevation: 2,
                    backgroundColor: Colors.white,
                    bottom: TabBar(
                      tabs: <Widget>[
                        Tab(
                          icon: Icon(
                            Icons.message,
                            color: Colors.black,
                          ),
                        ),
                        Tab(icon: Icon(Icons.favorite, color: Colors.red))
                      ],
                    ),
                  ),
                ),
                body: TabBarView(
                  children: <Widget>[
                    StreamProvider<List<Post>>.value(
                        value: DatabaseService(uid: user.uid).individualPosts,
                        child: PostList()),
                    StreamProvider<List<Post>>.value(
                        value: DatabaseService(uid: user.uid).likes,
                        child: PostList()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
