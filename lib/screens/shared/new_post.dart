import 'package:flutter/material.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          Text(
            "New Post",
            style: TextStyle(fontSize: 18.0)
          ),
          SizedBox(height: 20.0),
          TextField(
            decoration: const InputDecoration(
              hintText: "What is your enjoyment today?",
              border: OutlineInputBorder()
            )
          )
        ],
      )
    );
  }
}