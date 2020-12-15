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
  final Query postCollection = Firestore.instance.collectionGroup('posts').orderBy("time_created", descending: true);

  // call when a new user is registered
  Future updateUser(User user) async {
    return await userCollection.document(uid).setData({
      'username': user.username,
      'country': user.country,
      'state': user.state
    });
  }

  // call when a new post is added
  Future updatePost(String post, String time) async {
    String postId = Uuid().v4();
    return await userCollection.document(uid)
      .collection('posts').document(postId).setData({
      'content' : post,
      'creator_username' : currentUser.username,
      'creator_uid' : uid,
      'creator_country' : currentUser.country,
      'creator_state' : currentUser.state,
      'time_created' : time
    });
  }

  // call when a post is deleted
  Future deletePost(String postId) async {
    return await userCollection.document(uid)
      .collection('posts').document(postId).delete();
  }

  // get username of a user from database
  Future getUsername() {
    return userCollection.document(uid).get().then((value) {
      return value.data['username'];
    });
  }

  // get country of a user from database
  Future getCountry() {
    return userCollection.document(uid).get().then((value) {
      return value.data['country'];
    });
  }

  // get state of a user from database
  Future getState() {
    return userCollection.document(uid).get().then((value) {
      return value.data['state'];
    });
  }

  // get universal posts stream
  List<Post> _postListFromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map(
      (doc) {
        return Post(
          content: doc['content'], 
          creator: User(username: doc['creator_username'], uid: doc['creator_uid'], country: doc['creator_country'], state: doc['creator_state']),
          postId: doc.documentID
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