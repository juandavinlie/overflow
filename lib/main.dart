import 'package:flutter/material.dart';
import 'package:overflow/models/user.dart';
import 'package:overflow/screens/wrapper.dart';
import 'package:overflow/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:overflow/screens/pages/post_card.dart';

void main() {
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return StreamProvider<User>.value(
//       value: AuthService().user, // specifies what stream is being listened to
//       child: MaterialApp(
//         home: Wrapper(),
//       ),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            children: [
              PostCard(),
              PostCard(),
            ],
          ),
        ),
      ),
    );
  }
}
