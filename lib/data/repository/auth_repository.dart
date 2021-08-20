import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository(this._firebaseAuth);

  Future<User?> getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  Future<User?> loginWithEmailPassword({required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return _firebaseAuth.currentUser;
  }

  Future<User?> signupWithEmailPassword({required String email, required String password}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return _firebaseAuth.currentUser;
  }

  Future<bool> signupWithProfile({
    required String uid,
    required String fname,
    required String lname,
    required String email,
  }) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({
          'fname': fname,
          'lname': lname,
          'email': email,
        })
        .then((_) => Future<bool>.value(true))
        .catchError((error) => Future<bool>.value(false));
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    return;
  }
}
