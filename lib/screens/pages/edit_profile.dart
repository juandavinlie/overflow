import 'package:flutter/material.dart';
import 'package:overflow/screens/shared/constants.dart';
import 'package:overflow/services/database.dart';

class EditProfile extends StatefulWidget {

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  String newUsername = currentUser.username;
  String newBio = currentUser.bio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Username"),
            TextFormField(
              initialValue: currentUser.username,
              onChanged: (val) {
                newUsername = val;
              },
            ),
            Text("Bio"),
            TextFormField(
              initialValue: currentUser.bio,
              onChanged: (val) {
                newBio = val;
              },
            ),
            RaisedButton(child: Text("Change"), onPressed: () async {
              currentUser.setUsername(newUsername);
              currentUser.setBio(newBio);
              await DatabaseService(uid: currentUser.uid).updateUser(currentUser);
              DatabaseService(uid: currentUser.uid).updateUsernameOfPosts(currentUser.username);
              Navigator.pop(context);
            },),
          ],
        ),
      ),
    );
  }
}