import 'package:firebase_auth/firebase_auth.dart';
import 'package:overflow/models/user.dart';
import 'package:overflow/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // create user object based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
    .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  // sign in anon
  // Future signInAnon() async {
  //   try {
  //     AuthResult result = await _auth.signInAnonymously();
  //     FirebaseUser user = result.user;
  //     return _userFromFirebaseUser(user);
  //   } catch(e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      if (user != null) {
        String username = await DatabaseService(uid: user.uid).getUsername();
        String country = await DatabaseService(uid: user.uid).getCountry();
        String state = await DatabaseService(uid: user.uid).getState();
        String bio = await DatabaseService(uid: user.uid).getBio();
        //currentUser = User(uid: user.uid, username: username, country: country, state: state, bio: bio);
      }
      return _userFromFirebaseUser(user);
    } catch(e) {
      return null;
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(String email, String username, String countryValue, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      if (user != null) {
        User thisUser = User(uid: user.uid, username: username, country: countryValue, bio: "");
        //currentUser = thisUser;
        await DatabaseService(uid: user.uid).updateUser(thisUser);
      }
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}