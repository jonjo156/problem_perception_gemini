import 'package:problem_perception_landing/core/services/firestore_service.dart';
import 'package:problem_perception_landing/features/auth/models/user_model.dart';

class ProfileRepository {
  final FirestoreService _firestoreService;
  const ProfileRepository(this._firestoreService);

  Future<UserModel> getUser(String uid) {
    try {
      return _firestoreService.getUser(uid);
    } catch (e) {
      rethrow;
    }
  }
}
