import 'package:overflow/models/user.dart';

class Post {
  String content;
  User creator;
  String postId;
  String time;

  Post({ this.content, this.creator, this.postId, this.time});
}