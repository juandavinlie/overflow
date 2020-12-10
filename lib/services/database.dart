import 'package:cloud_firestore/cloud_firestore.dart';
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
      'creator' : uid
    });
  }

  // get universal posts stream
  Stream<QuerySnapshot> get universalPosts {
    return postCollection.snapshots();
  }

  // get individual posts stream
  Stream<QuerySnapshot> get individualPosts {
    return userCollection.document(uid).collection('posts').snapshots();
  }


}