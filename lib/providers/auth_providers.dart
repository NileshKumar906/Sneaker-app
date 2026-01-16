import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../core/firebase_providers.dart';
import '../services/auth_services.dart';

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

// Controller using AuthService for convenience (wraps create/signin/signout)
final authControllerProvider = Provider<AuthService>((ref) {
  return ref.read(authServiceProvider);
});
