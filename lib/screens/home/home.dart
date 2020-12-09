import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overflow/screens/pages/feed.dart';
import 'package:overflow/screens/pages/personal.dart';
import 'package:overflow/screens/shared/drawer.dart';
import 'package:overflow/screens/shared/new_post.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final _pages = [Feed(), Personal()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Overflow"),
        actions: <Widget>[FlatButton.icon(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context, 
              builder: (context) {
                return NewPost();
              }
            );
          }, 
          icon: Icon(Icons.add), 
          label: Text("New Post"))
        ],
      ),
      drawer: DrawerCustom(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home")
          ), 
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Personal")
          )
        ],
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
      ),
    );
  }
}