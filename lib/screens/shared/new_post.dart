import 'package:flutter/material.dart';
import 'package:overflow/models/user.dart';
import 'package:overflow/services/auth.dart';
import 'package:overflow/services/database.dart';
import 'package:provider/provider.dart';

class NewPost extends StatefulWidget {
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
    
    String enjoyment = '';
    
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            "New Post",
            style: TextStyle(fontSize: 18.0)
          ),
          SizedBox(height: 20.0),
          Container(
            height: 250.0,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    maxLines: 11,
                    decoration: InputDecoration(
                      hintText: "What is your enjoyment today?",
                      errorText: _valid ? null : "Enjoyment can't be empty",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(20),
                    ),
                    controller: controller,
                    autofocus: true,
                    onEditingComplete: () {
                      enjoyment = controller.text;
                    },
                  ),
                ]
              ),
            ),
          ),
          RaisedButton(
            child: Text("Post"),
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                await DatabaseService(uid: user.uid).updatePost(enjoyment);
                Navigator.pop(context);
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
      )
    );
  }
}