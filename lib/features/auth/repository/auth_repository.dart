import 'package:firebase_auth/firebase_auth.dart';
import 'package:problem_perception_landing/core/services/firestore_service.dart';
import 'package:problem_perception_landing/features/auth/models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirestoreService _firestoreService;

  const AuthRepository(this._firebaseAuth, this._firestoreService);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<UserModel?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final firebaseUser = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return UserModel(uid: firebaseUser.user!.uid, email: email);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      final firebaseUser = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return UserModel(uid: firebaseUser.user!.uid, email: email);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> signUpWithGoogle() async {
    try {
      final firebaseUser =
          await _firebaseAuth.signInWithPopup(GoogleAuthProvider());
      return UserModel(
          uid: firebaseUser.user!.uid, email: firebaseUser.user!.email!);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createProfile(UserModel user) async {
    try {
      await _firestoreService.addUser(user);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
