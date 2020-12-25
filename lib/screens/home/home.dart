import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overflow/models/localuser.dart';
import 'package:overflow/models/user.dart';
import 'package:overflow/screens/pages/feed.dart';
import 'package:overflow/screens/pages/personal.dart';
import 'package:overflow/screens/shared/drawer.dart';
import 'package:overflow/screens/shared/new_post.dart';
import 'package:overflow/services/database.dart';
import 'package:provider/provider.dart';
import 'package:overflow/screens/pages/pursue.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final _pages = [Feed(), Pursue(), Personal()];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamProvider<LocalUser>.value(
        value: DatabaseService(uid: user.uid).localUser,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.orange[100],
            elevation: 0,
            title: Text("Overflow"),
          ),
          drawer: DrawerCustom(),
          body: _pages[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Container(
                    height: 0,
                  )),
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                title: Container(
                  height: 0,
                ),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Container(
                    height: 0,
                  )),
            ],
            onTap: (value) {
              setState(() {
                _selectedIndex = value;
              });
            },
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
          ),
        ));
  }
}
