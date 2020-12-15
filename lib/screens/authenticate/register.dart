import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:overflow/screens/shared/constants.dart';
import 'package:overflow/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

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
  Country countryValue;
  String stateValue = '';
  String cityValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.orange[50],
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          margin: EdgeInsets.fromLTRB(20, 50, 20, 50),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Register to Overflow'),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Email"),
                      validator: (val) => val.isEmpty ? "Enter an email" : null,
                      onChanged: (val) {
                        email = val;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Username"),
                      validator: (val) =>
                          val.isEmpty ? "Enter a username" : null,
                      onChanged: (val) {
                        username = val;
                      },
                    ),
                    SizedBox(height: 20.0),
                    Align(
                      alignment: Alignment.centerLeft, 
                      child: Text("Choose your locality")
                    ),
                    SizedBox(height: 5.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CountryPicker(
                      dense: false,
                      showFlag: true,  //displays flag, true by default
                      showDialingCode: false, //displays dialing code, false by default
                      showName: true, //displays country name, true by default
                      showCurrency: false, //eg. 'British pound'
                      showCurrencyISO: false, //eg. 'GBP'
                      onChanged: (Country country) {
                        setState(() {
                          countryValue = country;
                        });
                      },
                      selectedCountry: countryValue,
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Password"),
                      validator: (val) => val.length < 6
                          ? "Enter a password of at least 6 characters long"
                          : null,
                      obscureText: true,
                      onChanged: (val) {
                        password = val;
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      child: Text("Register"),
                      onPressed: () async {
                        if (_formKey.currentState.validate() &&
                            countryValue.toString().isNotEmpty) {
                          dynamic result =
                              await _auth.registerWithEmailAndPassword(email,
                                  username, countryValue.name, stateValue, password);
                          if (result == null) {
                            setState(() {
                              error = "Please supply a valid email";
                            });
                          }
                        } else {
                          setState(() {
                            error = 'Please key in your locality.';
                          });
                        }
                      },
                    ),
                    SizedBox(height: 20.0),
                    RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                          text: 'Sign In',
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              widget.toggleView();
                            })
                    ])),
                    SizedBox(height: 12.0),
                    Text(error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    // );
    // Scaffold(
    //   appBar: AppBar(
    //     elevation: 0.0,
    //     title: Text("Register to Overflow")
    //   ),
    //   body: Container(
    //     padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
    //     child: Form(
    //       key: _formKey,
    //       child: SingleChildScrollView(
    //         child: Column(
    //           children: <Widget>[
    //             SizedBox(height: 20.0),
    //             TextFormField(
    //               decoration: InputDecoration(
    //                 hintText: "Email"
    //               ),
    //               validator: (val) => val.isEmpty ? "Enter an email" : null,
    //               onChanged: (val) {
    //                 email = val;
    //               },
    //             ),
    //             SizedBox(height: 20.0),
    //             TextFormField(
    //               decoration: InputDecoration(
    //                 hintText: "Username"
    //               ),
    //               validator: (val) => val.isEmpty ? "Enter a username" : null,
    //               onChanged: (val) {
    //                 username = val;
    //               },
    //             ),
    //             SizedBox(height: 20.0),
    //             SelectState(
    //               onCountryChanged: (value) {
    //                 setState(() {
    //                   countryValue = value;
    //                 });
    //               },
    //               onStateChanged:(value) {
    //                 setState(() {
    //                   stateValue = value;
    //                 });
    //               },
    //               onCityChanged:(value) {
    //                 setState(() {
    //                   cityValue = value;
    //                 });
    //               },
    //             ),
    //             SizedBox(height: 20.0),
    //             TextFormField(
    //               decoration: InputDecoration(
    //                 hintText: "Password"
    //               ),
    //               validator: (val) => val.length < 6 ? "Enter a password of at least 6 characters long" : null,
    //               obscureText: true,
    //               onChanged: (val) {
    //                 password = val;
    //               },
    //             ),
    //             SizedBox(height: 20.0),
    //             RaisedButton(
    //               child: Text("Register"),
    //               onPressed: () async {
    //                 if (_formKey.currentState.validate() && cityValue.isNotEmpty) {
    //                   dynamic result = await _auth.registerWithEmailAndPassword(email, username, countryValue, stateValue, password);
    //                   if (result == null) {
    //                     setState(() {
    //                       error = "Please supply a valid email";
    //                     });
    //                   }
    //                 } else {
    //                   setState(() {
    //                     error = 'Please key in your locality.';
    //                   });
    //                 }
    //               },
    //             ),
    //             SizedBox(height: 20.0),
    //             RichText(
    //               text: TextSpan(
    //                 children: <TextSpan>[
    //                   TextSpan(
    //                     text: "Already have an account? ",
    //                     style: TextStyle(color: Colors.black)
    //                   ),
    //                   TextSpan(
    //                     text: 'Sign In',
    //                     style: TextStyle(color: Colors.blue),
    //                     recognizer: TapGestureRecognizer()
    //                       ..onTap = () {
    //                         widget.toggleView();
    //                       }
    //                   )
    //                 ]
    //               )
    //             ),
    //             SizedBox(height: 12.0),
    //             Text(
    //               error,
    //               style: TextStyle(color: Colors.red, fontSize: 14.0)
    //             )
    //           ],
    //         ),
    //       ),
    //     )
    //   )
    // );
  }
}
