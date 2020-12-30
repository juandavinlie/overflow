import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:overflow/models/localuser.dart';
import 'package:overflow/models/user.dart';
import 'package:overflow/services/auth.dart';
import 'package:overflow/services/database.dart';
import 'package:provider/provider.dart';

class NewPost extends StatefulWidget {

  Function loadNewerPost;
  Function stopLoadingNewPost;

  NewPost({this.loadNewerPost, this.stopLoadingNewPost});

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  bool _valid = true;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final user = Provider.of<User>(context);
    final localUser = Provider.of<LocalUser>(context);

    String enjoyment = '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text('New Post', style: TextStyle(color: Colors.black))
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              Container(
                height: 250.0,
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    TextField(
                      maxLines: 11,
                      decoration: InputDecoration(
                        hintText: "What is your enjoyment today?",
                        errorText: _valid ? null : "Enjoyment can't be empty",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(20),
                      ),
                      controller: controller,
                      autofocus: false,
                      onChanged: (val) {
                        enjoyment = val;
                      },
                    ),
                  ]),
                ),
              ),
              RaisedButton(
                child: Text("Post"),
                onPressed: () async {
                  if (controller.text.isNotEmpty) {
                    int millisecondsSinceEpoch =
                        DateTime.now().millisecondsSinceEpoch;
                    // print(localTime.toString());
                    // DateTime utcTime = DateTime.utc(localTime.year, localTime.month, localTime.day, localTime.hour, localTime.minute, localTime.second, localTime.millisecond, localTime.microsecond);
                    // print(utcTime.toString());
                    widget.loadNewerPost();
                    await DatabaseService(uid: user.uid).updatePost(
                        enjoyment,
                        localUser.username,
                        localUser.country,
                        millisecondsSinceEpoch);
                    Navigator.pop(context);
                    widget.stopLoadingNewPost();
                  } else {
                    setState(() {
                      _valid = false;
                    });
                  }
                },
              ),
              RaisedButton(
                child: Text("Cancel"),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ],
          )),
    );
  }
}
