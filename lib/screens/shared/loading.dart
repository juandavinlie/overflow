import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("CALLED");
    return Container(
        color: Colors.orange[50],
        child:
            Center(child: SpinKitCircle(color: Colors.blue, size: 50.0)));
  }
}