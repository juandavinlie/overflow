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

class _PersonalState extends State<Personal>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _scrollViewController = ScrollController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   body: Column(
    //     children: [
    //       Profile(),
    //       DefaultTabController(
    //         length: 2,
    //         child: Scaffold(
    //           appBar: PreferredSize(
    //             preferredSize: Size.fromHeight(50),
    //             child: AppBar(
    //               elevation: 2,
    //               backgroundColor: Colors.white,
    //               bottom: TabBar(
    //                 tabs: <Widget>[
    //                   Tab(
    //                     icon: Icon(
    //                       Icons.message,
    //                       color: Colors.black,
    //                     ),
    //                   ),
    //                   Tab(icon: Icon(Icons.favorite, color: Colors.red))
    //                 ],
    //               ),
    //             ),
    //           ),
    //           body: TabBarView(
    //             children: <Widget>[
    //               StreamProvider<List<Post>>.value(
    //                   value: DatabaseService(uid: user.uid).individualPosts,
    //                   child: PostList()),
    //               StreamProvider<List<Post>>.value(
    //                   value: DatabaseService(uid: user.uid).likes,
    //                   child: PostList()),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Profile(),
              pinned: true,
              floating: true,
              forceElevated: boxIsScrolled,
              bottom: TabBar(
                controller: _tabController,
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
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            StreamProvider<List<Post>>.value(
                value: DatabaseService(uid: user.uid).individualPosts,
                child: PostList(scrollController: _scrollViewController,)),
            StreamProvider<List<Post>>.value(
                value: DatabaseService(uid: user.uid).likes, 
                child: PostList(scrollController: _scrollViewController,)),
          ],
        ),
        // Column(
        //   children: [
        //     Profile(),
        //     DefaultTabController(
        //       length: 2,
        //       child: Scaffold(
        //         appBar: PreferredSize(
        //           preferredSize: Size.fromHeight(50),
        //           child: AppBar(
        //             elevation: 2,
        //             backgroundColor: Colors.white,
        //             bottom: TabBar(
        //               tabs: <Widget>[
        //                 Tab(
        //                   icon: Icon(
        //                     Icons.message,
        //                     color: Colors.black,
        //                   ),
        //                 ),
        //                 Tab(icon: Icon(Icons.favorite, color: Colors.red))
        //               ],
        //             ),
        //           ),
        //         ),
        //         body: TabBarView(
        //           children: <Widget>[
        //             StreamProvider<List<Post>>.value(
        //                 value: DatabaseService(uid: user.uid).individualPosts,
        //                 child: PostList()),
        //             StreamProvider<List<Post>>.value(
        //                 value: DatabaseService(uid: user.uid).likes,
        //                 child: PostList()),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
