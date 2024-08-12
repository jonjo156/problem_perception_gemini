import 'package:problem_perception_landing/core/services/firestore_service.dart';
import 'package:problem_perception_landing/features/results/models/result_model.dart';

class SavedRepository {
  final FirestoreService _firestoreService;
  SavedRepository(this._firestoreService);

  Future<List<ResultModel>> loadFavorites(String uid) {
    return _firestoreService.getFavorites(uid);
  }
}
