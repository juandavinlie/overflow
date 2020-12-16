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
            Text("Username"),
            TextFormField(
              initialValue: newUsername,
              onChanged: (val) {
                newUsername = val;
              },
            ),
            Text("Bio"),
            TextFormField(
              initialValue: newBio,
              onChanged: (val) {
                newBio = val;
              },
            ),
            RaisedButton(child: Text("Change"), onPressed: () async {
              //currentUser.setUsername(newUsername);
              //currentUser.setBio(newBio);
              await DatabaseService(uid: data['localUserUid']).updateUser(User(
                uid: data['localUserUid'], 
                username: newUsername,
                country: data['localUserCountry'],
                bio: newBio)
              );
              DatabaseService(uid: data['localUserUid']).updateUsernameOfPosts(newUsername);
              Navigator.pop(context);
            },),
          ],
        ),
      ),
    );
  }
}