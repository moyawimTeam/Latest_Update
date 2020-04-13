import 'package:firebase_auth/firebase_auth.dart';
import 'package:two/Database/database.dart';
import 'package:two/Models/User.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on firebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  //sign in with email and password
  Future loginWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPasswordEmployee(
      String email,
      String password,
      String firstname,
      String lastname,
      String job,
      String city,
      String phonenb,
      String description) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseOperations(uid: user.uid).updateEmployeeData(
          firstname, lastname, job, city, phonenb, description);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future registerWithEmailAndPasswordEmployer(String email, String password,
      String firstname, String lastname, String phonenb) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseOperations(uid: user.uid)
          .updateEmployerData(firstname, lastname, phonenb);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  //sign out
  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String> getUserUid() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
//    final Firestore _firestore = Firestore.instance;
    FirebaseUser user = await _auth.currentUser();
//    Stream<DocumentSnapshot> ref;
//    try {
//      ref = _firestore.collection('Employers').document(user.uid).snapshots();
//    } catch (e) {
//      ref = _firestore.collection('Employees').document(user.uid).snapshots();
//    }
    return user.uid;
  }
}
