import 'package:flutter/material.dart';
import 'package:overflow/models/localuser.dart';
import 'package:overflow/models/user.dart';
import 'package:overflow/screens/shared/constants.dart';
import 'package:overflow/services/database.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  
  String newUsername = "";
  String newBio = "";
  Map data = {};

  @override
  Widget build(BuildContext context) {

    //final localUser = Provider.of<LocalUser>(context);
    
    data = ModalRoute.of(context).settings.arguments;

    newUsername = data['localUserUsername'];
    newBio = data['localUserBio'];

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
            Text("Full Name"),
            TextFormField(
              initialValue: newUsername,
              onChanged: (val) {
                newUsername = val;
              },
              maxLength: 50,
            ),
            Text("Bio"),
            TextFormField(
              initialValue: newBio,
              onChanged: (val) {
                newBio = val;
              },
              maxLength: 150,
            ),
            RaisedButton(child: Text("Change"), onPressed: () async {
              String parsedName = newUsername.split(" ").map((str) => '${str[0].toUpperCase()}${str.substring(1)}').join(" ");
              await DatabaseService(uid: data['localUserUid']).updateUser(User(
                uid: data['localUserUid'], 
                username: parsedName,
                country: data['localUserCountry'],
                bio: newBio)
              );
              DatabaseService(uid: data['localUserUid']).updateUsernameOfPosts(parsedName);
              Navigator.pop(context);
            },),
          ],
        ),
      ),
    );
  }
}