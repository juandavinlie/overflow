import 'package:overflow/models/user.dart';

class Post {
  String content;
  User creator;
  String postId;
  DateTime time;
  bool liked;

  Post({ this.content, this.creator, this.postId, this.time, this.liked});
}