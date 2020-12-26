import 'package:flutter/material.dart';
import 'package:overflow/models/user.dart';
import 'package:overflow/screens/pages/edit_profile.dart';
import 'package:overflow/screens/pages/profile.dart';
import 'package:overflow/screens/wrapper.dart';
import 'package:overflow/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:overflow/screens/pages/post_card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user, // specifies what stream is being listened to
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Wrapper(),
          '/editprofile': (context) => EditProfile()
        },
      ),
    );
  }
}
