import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:overflow/screens/home/home.dart';
import 'package:overflow/services/auth.dart';
import 'package:uuid/uuid.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;

  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

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
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Email"
                ),
                validator: (val) => val.isEmpty ? "Enter an email" : null,
                onChanged: (val) {
                  email = val;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Password"
                ),
                validator: (val) => val.length < 6 ? "Enter a password of at least 6 characters long" : null,
                obscureText: true,
                onChanged: (val) {
                  password = val;
                },
              ), 
              SizedBox(height: 20.0),
              RaisedButton(
                child: Text("Sign In"),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if (result == null) {
                        setState(() {
                          error = "Your account doesn't exist";
                        });
                      }
                  }
                },
              ),
              SizedBox(height: 20.0),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: Colors.black)
                    ),
                    TextSpan(
                      text: 'Register',
                      style: TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          widget.toggleView();
                        }
                    )
                  ]
                )
              )
            ],
          ),
        )
      )
    );
  }
}