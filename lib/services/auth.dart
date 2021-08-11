import 'package:brew_crew/models/user.dart' as localUser;
import 'package:brew_crew/services/database/brew_database.dart';
import 'package:brew_crew/services/exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthContracts {
  // sign in anon
  Future signInAnon();

  // sign in email & password
  Future signInWithEmilPassword({
    required String email,
    required String password,
  });

  // register with email & password
  Future registerWithEmailPassword({
    required String email,
    required String password,
  });

  // sign out
  Future signOut();
}

class AuthService implements AuthContracts {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  localUser.User? _userFromFirebaseUser(User? user) {
    return user != null ? localUser.User(uid: user.uid) : null;
  }

  Stream<localUser.User?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  @override
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Future registerWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;

      //Create initial brew dummy data
      await BrewDatabaseService(uid: user!.uid).updateData(
        sugars: '0',
        name: 'new crew member',
        strength: 100,
      );

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      throw ErrorMessage(e.toString());
    }
  }

  @override
  Future signInWithEmilPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        return _userFromFirebaseUser(result.user);
      } else {
        throw ErrorMessage("User tidak ditemukan");
      }
    } catch (e) {
      print(e.toString());
      throw ErrorMessage(e.toString());
    }
  }
}
