import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_sneakers/core/firebase_providers.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  final auth = ref.read(firebaseAuthProvider);
  final firestore = ref.read(firestoreProvider);
  return AuthService(auth, firestore);
});

class AuthService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthService(this._auth, this._firestore);

  /// SIGN UP
  Future<User?> signUp({
    required String email,
    required String password,
  }) async {
    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = result.user;

    if (user != null) {
      // 🔥 CREATE USER DOCUMENT WITH ROLE
      await _firestore.collection('users').doc(user.uid).set({
        'email': email,
        'role': 'user', // default role
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    return user;
  }

  /// SIGN IN
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  /// SIGN OUT
  Future<void> signOut() => _auth.signOut();

  /// CURRENT USER
  User? get currentUser => _auth.currentUser;
}
