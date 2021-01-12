import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:overflow/models/localuser.dart';
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
      'bio': user.bio
    });
  }

  // call when a new post is added
  Future updatePost(String content, String username, String country, int time) async {
    String postId = Uuid().v4();
    return await userCollection.document(uid)
      .collection('posts').document(postId).setData({
      'content' : content,
      'creator_username' : username,
      'creator_uid' : uid,
      'creator_country' : country,
      'time_created' : time,
      'liked_by': []
    });
  }

  Future addLikedBy(String postId, String likerId) async {
    return await userCollection.document(uid)
      .collection('posts').document(postId).updateData({
        'liked_by': FieldValue.arrayUnion([likerId])
      });
  }

  Future removeLikedBy(String postId, String likerId) async {
    return await userCollection.document(uid)
      .collection('posts').document(postId).updateData({
        'liked_by': FieldValue.arrayRemove([likerId])
      });
  }

  void updateUsernameOfPosts(String newUsername) {
    userCollection.document(uid).collection('posts').getDocuments().then(
      (snapshot) {
        snapshot.documents.forEach(
          (element) {
            element.reference.updateData({
              'creator_username': newUsername
            });
          });
      } 
    );
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

  // get bio of a user from database
  Future getBio() {
    return userCollection.document(uid).get().then((value) {
      return value.data['bio'];
    });
  }

  List<Post> _postListFromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map(
      (doc) {
        try {
          return Post(
            content: doc['content'], 
            creator: User(username: doc['creator_username'], uid: doc['creator_uid'], country: doc['creator_country']),
            postId: doc.documentID,
            time: DateTime.fromMillisecondsSinceEpoch(doc['time_created']).toLocal(),
            liked: doc['liked_by'].contains(uid)
          ); 
        } catch(e) {
          //print(e);
          return Post(
            content: doc['content'], 
            creator: User(username: doc['creator_username'], uid: doc['creator_uid'], country: doc['creator_country']),
            postId: doc.documentID,
            time: DateTime.fromMillisecondsSinceEpoch(doc['time_created']).toLocal(),
            liked: false
          ); 
        }
        
      }
    ).toList();
  }

  LocalUser _localUserFromDocumentSnapshot(DocumentSnapshot snapshot) {
    String username = snapshot.data['username'];
    String country = snapshot.data['country'];
    String bio = snapshot.data['bio'] ?? "";
    return LocalUser(uid: uid, username: username, country: country, bio: bio);
  }

  // get likes stream

  Stream<List<Post>> likesPostsFromStart(int limit) {
    Stream<List<Post>> stream =  postCollection.where('liked_by', arrayContains: uid).limit(limit).snapshots(includeMetadataChanges: true).map(_postListFromQuerySnapshot);
    return stream;
  }

  Stream<List<Post>> likesPostsFromStartToLastLoadedPost(int lastTimeCreated) {
    Stream<List<Post>> stream =  postCollection.where('liked_by', arrayContains: uid).endAt([lastTimeCreated]).snapshots().map(_postListFromQuerySnapshot);
    return stream;
  }

  Stream<List<Post>> nextLikesPostsWithoutNew(int timeCreated, int limit) {
    Stream<List<Post>> stream =  postCollection.where('liked_by', arrayContains: uid).startAt([timeCreated]).limit(limit).snapshots().map(_postListFromQuerySnapshot);
    return stream;
  }

  Stream<List<Post>> get likes {
    return postCollection.where('liked_by', arrayContains: uid).snapshots().map(_postListFromQuerySnapshot);
  }

  // get universal posts stream

  Stream<List<Post>> universalPostsFromStart(int limit) {
    Stream<List<Post>> stream =  postCollection.limit(limit).snapshots().map(_postListFromQuerySnapshot);
    return stream;
  }

  Stream<List<Post>> universalPostsFromStartToLastLoadedPost(int lastTimeCreated) {
    Stream<List<Post>> stream =  postCollection.endAt([lastTimeCreated]).snapshots().map(_postListFromQuerySnapshot);
    return stream;
  }

  Stream<List<Post>> nextUniversalPostsWithoutNew(int timeCreated, int limit) {
    Stream<List<Post>> stream =  postCollection.startAt([timeCreated]).limit(limit).snapshots().map(_postListFromQuerySnapshot);
    return stream;
  }

  Stream<List<Post>> get universalPosts {
    return postCollection.snapshots().map(_postListFromQuerySnapshot);
  }

  // get individual posts stream

  Stream<List<Post>> individualPostsFromStart(int limit) {
    Stream<List<Post>> stream =  userCollection.document(uid).collection('posts').limit(limit).snapshots().map(_postListFromQuerySnapshot);
    return stream;
  }

  Stream<List<Post>> individualPostsFromStartToLastLoadedPost(int lastTimeCreated) {
    Stream<List<Post>> stream =  userCollection.document(uid).collection('posts').endAt([lastTimeCreated]).snapshots().map(_postListFromQuerySnapshot);
    return stream;
  }

  Stream<List<Post>> nextIndividualPostsWithoutNew(int timeCreated, int limit) {
    Stream<List<Post>> stream =  userCollection.document(uid).collection('posts').startAt([timeCreated]).limit(limit).snapshots().map(_postListFromQuerySnapshot);
    return stream;
  }

  Stream<List<Post>> get individualPosts {
    return userCollection.document(uid).collection('posts').snapshots().map(_postListFromQuerySnapshot);
  }

  Stream<LocalUser> get localUser {
    return userCollection.document(uid).snapshots().map(_localUserFromDocumentSnapshot);
  }


}