import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:overflow/models/localuser.dart';
import 'package:overflow/models/user.dart';
import 'package:overflow/screens/shared/constants.dart';
import 'package:overflow/services/auth.dart';
import 'package:overflow/services/database.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class NewPost extends StatefulWidget {
  Function loadNewerPost;
  Function stopLoadingNewPost;
  ScrollController feedScrollController;

  NewPost({this.loadNewerPost, this.stopLoadingNewPost, this.feedScrollController});

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
        actions: [
          RaisedButton(
                child: Text("Post"),
                onPressed: () async {
                  if (controller.text.isNotEmpty) {
                    int millisecondsSinceEpoch =
                        DateTime.now().millisecondsSinceEpoch;
                    // print(localTime.toString());
                    // DateTime utcTime = DateTime.utc(localTime.year, localTime.month, localTime.day, localTime.hour, localTime.minute, localTime.second, localTime.millisecond, localTime.microsecond);
                    // print(utcTime.toString());
                    //widget.loadNewerPost();
                    await DatabaseService(uid: user.uid).updatePost(
                        enjoyment,
                        localUser.username,
                        localUser.country,
                        millisecondsSinceEpoch);
                    Navigator.pop(context);
                    //widget.feedScrollController.animateTo(widget.feedScrollController.position.minScrollExtent, duration: Duration(milliseconds: 750), curve: Curves.easeIn);
                  } else {
                    setState(() {
                      _valid = false;
                    });
                  }
                },
              ),
        ],
          backgroundColor: Colors.grey[50],
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text('New Post', style: TextStyle(color: Colors.black))),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8,8,8,0),
            child: Column(
              children: <Widget>[
                Container(
                  height: 250.0,
                  child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                      Row(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 10),
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/squidward.jpg'),
                                radius: 25,
                              ),
                              SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    localUser.username,
                                    style: GoogleFonts.lato(
                                      color: Colors.grey[850],
                                      letterSpacing: 2,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    ' ',
                                    // widget.post.time.millisecondsSinceEpoch.toString(),
                                    style: GoogleFonts.lato(
                                      color: Colors.grey[600],
                                      letterSpacing: 2,
                                      fontSize: 10,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    localUser.country,
                                    style: GoogleFonts.lato(
                                      letterSpacing: 2,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      TextField(
                        maxLines: 11,
                        decoration: InputDecoration(
                          hintText: "What is your enjoyment today?",
                          errorText: _valid ? null : "Enjoyment can't be empty",
                          border: InputBorder.none,
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
                
                // RaisedButton(
                //   child: Text("Cancel"),
                //   onPressed: () async {
                //     Navigator.pop(context);
                //   },
                // ),
              ],
            ),
          )),
    );
  }
}
