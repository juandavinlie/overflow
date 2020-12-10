import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:overflow/models/post.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  
  final String uid; 
  final String username;

  DatabaseService({ this.uid, this.username });

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
  List<Post> _postListFromQuerySnapshot(QuerySnapshot snapshot) {

    return snapshot.documents.map(
      (doc) {
        // String username = 'hihi';
        // userCollection.getDocuments().then((snapshot) => {
        //   snapshot.documents.forEach((document) {
        //     if (document.documentID == doc['creator']) {
        //       username = document['username'];
        //       print(username);
        //     }
        //   })
        // });
        // print(username + " BELAKANGAN");
        return Post(
          content: doc['content'], 
          username: doc['creator']
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