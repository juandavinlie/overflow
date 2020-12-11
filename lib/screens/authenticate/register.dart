import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:overflow/screens/shared/constants.dart';
import 'package:overflow/services/auth.dart';

class Register extends StatefulWidget {

  final Function toggleView;

  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String username = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Register to Overflow")
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
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
                    hintText: "Username"
                  ),
                  validator: (val) => val.isEmpty ? "Enter a username" : null,
                  onChanged: (val) {
                    username = val;
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
                  child: Text("Register"),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      dynamic result = await _auth.registerWithEmailAndPassword(email, username, password);
                      if (result == null) {
                        setState(() {
                          error = "Please supply a valid email";
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
                        text: "Already have an account? ",
                        style: TextStyle(color: Colors.black)
                      ),
                      TextSpan(
                        text: 'Sign In',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            widget.toggleView();
                          }
                      )
                    ]
                  )
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0)
                )
              ],
            ),
          ),
        )
      )
    );
  }
}