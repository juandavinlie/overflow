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
      backgroundColor: Colors.white,
      body: Center(
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 8,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Center(
                          child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Register to Overflow',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height: 20.0),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              validator: (val) =>
                                  val.isEmpty ? "Enter an email" : null,
                              onChanged: (val) {
                                email = val;
                              },
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Full Name",
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              validator: (val) =>
                                  val.isEmpty ? "Enter your full name" : null,
                              onChanged: (val) {
                                username = val;
                              },
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              validator: (val) => val.length < 6
                                  ? "Enter a password of at least 6 characters long"
                                  : null,
                              obscureText: true,
                              onChanged: (val) {
                                password = val;
                              },
                            ),
                            SizedBox(height: 20.0),
                            Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                alignment: Alignment.centerLeft,
                                child: Text("Locality")),
                            SizedBox(height: 5.0),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.black.withOpacity(0.5))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: CountryPicker(
                                    dense: false,
                                    showFlag:
                                        true, //displays flag, true by default
                                    showDialingCode:
                                        false, //displays dialing code, false by default
                                    showName:
                                        true, //displays country name, true by default
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
                              ),
                            ),
                            SizedBox(height: 20),
                            RaisedButton(
                              child: Text("Register"),
                              onPressed: () async {
                                if (_formKey.currentState.validate() &&
                                    countryValue.toString().isNotEmpty) {
                                  dynamic result =
                                      await _auth.registerWithEmailAndPassword(
                                          email,
                                          username.split(" ").map((str) => '${str[0].toUpperCase()}${str.substring(1)}').join(" "),
                                          countryValue.name,
                                          password);
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
                          ],
                        ),
                      ))),
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 0.4,
                height: 0,
                indent: 20,
                endIndent: 20,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                              text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: "Already have an account? ",
                                style: TextStyle(color: Colors.black)),
                            TextSpan(
                                text: 'Sign in',
                                style: TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    widget.toggleView();
                                  })
                          ])),
                          SizedBox(height: 12.0),
                          Text(error,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 14.0))
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
