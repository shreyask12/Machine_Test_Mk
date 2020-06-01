import 'package:firebase_auth/firebase_auth.dart';
import 'package:machine_test_ex/models/user.dart';




abstract class AuthBase {
  Stream<User> get user;
  Future<User> currentUser();
  Future<User> signInWithEmailAndPassword(String email,String password);
  Future<User> createUserWithEmailAndPassword(String email,String password);
  Future<void> signOut();
  Future<User> signInAnonymously();
  // void dispose();
}

class FireBaseAuthService implements AuthBase{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    if(user == null){
      return null;
    }
    return User(uid: user.uid);
  }

  @override
  Stream<User> get user {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  @override
  Future<User> currentUser() async {
    final user =  await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }


  @override
  Future<User> signInWithEmailAndPassword(String email,String password) async {

    final authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> createUserWithEmailAndPassword(String email,String password) async {

    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> signInAnonymously() async{
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }



  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // @override
  // void dispose() {
  
  // }

}