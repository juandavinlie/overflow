import 'package:flutter/material.dart';
import 'package:overflow/screens/home/home.dart';
import 'package:overflow/services/auth.dart';
import 'package:uuid/uuid.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Sign in to Overflow")
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  onChanged: (val) {
                    email = val;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  obscureText: true,
                  onChanged: (val) {
                    password = val;
                  },
                ), 
                SizedBox(height: 20.0),
                RaisedButton(
                  child: Text("Sign In"),
                  onPressed: () {

                  },
                )
              ],
            ),
          )
        )
      );
  }
}