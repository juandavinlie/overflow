import 'package:flutter/material.dart';
import 'package:overflow/services/auth.dart';

class DrawerCustom extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text("Profile Stuff") 
            ),
            FlatButton.icon(
              onPressed: () {
                _auth.signOut();
              }, 
              icon: Icon(Icons.exit_to_app), 
              label: Text("Sign Out")
            )
          ],
        )
      );
  }
}