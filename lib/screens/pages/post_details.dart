import 'package:flutter/material.dart';
import 'package:overflow/models/post.dart';
import 'package:reference_parser/reference_parser.dart';

class PostDetail extends StatefulWidget {
  final Post post;

  PostDetail({this.post});

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
    var refs = parseAllReferences(widget.post.content);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.post.content),
          Verses(post: widget.post),
        ],
      ),
    );
  }
}

class Verses extends StatefulWidget {
  final Post post;

  Verses({this.post});

  @override
  _VersesState createState() => _VersesState();
}

class _VersesState extends State<Verses> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var refs = parseAllReferences(widget.post.content);

    return refs.length == 0
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              Container(
                  child: Wrap(
                    spacing: 10,
                    children: refs
                        .map((verse) => new Text(verse.toString()))
                        .toList(),
                  ))
            ],
          );
  }
}
