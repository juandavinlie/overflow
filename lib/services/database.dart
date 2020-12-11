import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:overflow/models/post.dart';
import 'package:overflow/models/user.dart';
import 'package:overflow/screens/shared/constants.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  
  final String uid; 

  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');
  final Query postCollection = Firestore.instance.collectionGroup('posts');

  // call when a new user is registered
  Future updateUser(String username) async {
    return await userCollection.document(uid).setData({
      'username': username
    });
  }

  // call when a new post is added
  Future updatePost(String post) async {
    String postId = Uuid().v4();
    return await userCollection.document(uid)
      .collection('posts').document(postId).setData({
      'content' : post,
      'creator_username' : currentUser.username,
      'creator_uid' : uid,
    });
  }

  // get username of a user from database
  Future getUsername() {
    return userCollection.document(uid).get().then((value) {
      return value.data['username'];
    });
  }

  // get universal posts stream
  List<Post> _postListFromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map(
      (doc) {
        // await userCollection.document(doc['creator']).get().then((snapshot) {
        //   username = snapshot.data['username'];
        // });  
        return Post(
          content: doc['content'], 
          creator: User(username: doc['creator_username'], uid: doc['creator_uid'])
        ); 
      }
    ).toList();
  }


  Stream<List<Post>> get universalPosts {
    return postCollection.snapshots().map(_postListFromQuerySnapshot);
  }

  // get individual posts stream
  Stream<List<Post>> get individualPosts {
    return userCollection.document(uid).collection('posts').snapshots().map(_postListFromQuerySnapshot);
  }


}