import 'package:flutter/material.dart';
import 'package:overflow/models/user.dart';
import 'package:overflow/screens/authenticate/authenticate.dart';
import 'package:overflow/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    
    //returns Home or Authenticate widget depending on user authentication status
    return user != null ? Home() : Authenticate();
  }
}