import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_app/models/user.dart';
import 'package:flutter_firebase_app/services/dataBase.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create userobject based on firebase uid
  UserEntity? _userEntityFromFirebaseUser(User? user){
    return user != null ? UserEntity(uid: user.uid) : null;
  }
  
  //auth change userstream
  Stream<UserEntity?> get user{
    return _auth.authStateChanges()
    .map((User? user) => _userEntityFromFirebaseUser(user));
  }
  //sign in anonymously
  Future signInAnon() async {
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userEntityFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
}

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      var result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userEntityFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return e;

    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      var result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      //create doc for new user
      await DatabaseService(uid: user!.uid).updateUserData('Water', 'New member', 100);
      return _userEntityFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return e;

    }
  }

  //sign out

  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}