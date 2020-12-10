import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UniversalPostList extends StatefulWidget {
  @override
  _UniversalPostListState createState() => _UniversalPostListState();
}

class _UniversalPostListState extends State<UniversalPostList> {
  @override
  Widget build(BuildContext context) {

    final universalPosts = Provider.of<QuerySnapshot>(context);

    return Container(
      
    );
  }
}