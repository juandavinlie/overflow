import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  
  final String uid; 

  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');
  final CollectionReference postCollection = Firestore.instance.collectionGroup('posts');

  // call when a new user 
  Future updateUser(String username) async {
    return await userCollection.document(uid).setData({
      'username' : username
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


}