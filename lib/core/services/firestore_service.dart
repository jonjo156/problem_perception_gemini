import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:problem_perception_landing/features/auth/models/user_model.dart';
import 'package:problem_perception_landing/features/results/models/result_model.dart';

class FirestoreService {
  final FirebaseFirestore _firebaseFirestore;
  const FirestoreService(this._firebaseFirestore);

  Future<void> addUser(UserModel user) {
    try {
      return _firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .set(user.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getUser(String uid) {
    try {
      return _firebaseFirestore
          .collection('users')
          .doc(uid)
          .get()
          .then((doc) => UserModel.fromJson(doc.data()!));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveResults(String uid, List<ResultModel> results) {
    try {
      final List resultsJson = results.map((e) => e.toJson()).toList();
      return _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection('results')
          .add({
        'results': resultsJson,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveResultToFavorites(String uid, ResultModel result) {
    try {
      return _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection('favorites')
          .add(result.toJson());
    } catch (e) {
      rethrow;
    }
  }

  // Get all favorites
  Future<List<ResultModel>> getFavorites(String uid) {
    try {
      return _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection('favorites')
          .get()
          .then((snapshot) => snapshot.docs
              .map((doc) => ResultModel.fromJson(doc.data()))
              .toList());
    } catch (e) {
      rethrow;
    }
  }

  // Get all results
  Stream<List<ResultModel>> getResultsHistory(String uid) {
    try {
      return _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection('results')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => ResultModel.fromJson(doc.data()))
              .toList());
    } catch (e) {
      rethrow;
    }
  }
}
