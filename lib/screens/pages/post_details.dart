import 'package:flutter/material.dart';
import 'package:overflow/models/post.dart';
import 'package:reference_parser/reference_parser.dart';
import 'package:bible/bible.dart' as Bible;
import 'package:overflow/screens/shared/loading.dart';

class PostDetail extends StatefulWidget {
  final Post post;

  PostDetail({this.post});

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.post.content),
          Divider(color: Colors.grey[850],),
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
  List<List> psge = new List<List>();

  Future<void> getVerse(List ref) async {
    List<List> listOfVerses = new List<List>();
    for (var i = 0; i < ref.length; i++) {
      if (ref[i].referenceType == ReferenceType.BOOK) {
        continue;
      } else {
        var passage = await Bible.queryPassage(ref[i].toString());
        listOfVerses.add([ref[i], passage.passage]);
      }
    }
    return listOfVerses;
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    var refs = parseAllReferences(widget.post.content);

    return FutureBuilder(
        future: getVerse(refs),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return refs.length == 0
                ? Container(child: Text('NO VERSES'))
                : Padding(
                  padding: const EdgeInsets.fromLTRB(8,0,8,0),
                  child: Container(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: snapshot.data
                          .map<Widget>(
                              (psg) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(child: Text(psg[0].toString())),
                                        Text(psg[1] + "\n"),
                                      ],
                                    ))
                          .toList(),
                    )),
                );
          } else {
            return Loading();
          }
        });
  }
}
