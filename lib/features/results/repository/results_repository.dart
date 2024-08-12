import 'dart:async';
import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:problem_perception_landing/core/services/firestore_service.dart';

import '../models/result_model.dart';

class ResultsRepository {
  final FirebaseFunctions _firebaseFunctions;
  final FirestoreService _firestoreService;
  ResultsRepository(this._firebaseFunctions, this._firestoreService);

  Future<List<ResultModel>> createDocumentAndGetResponse(
      Map<String, dynamic> data, String uid) async {
    try {
      HttpsCallable callable = _firebaseFunctions.httpsCallable(
        'get_pain_points',
        options: HttpsCallableOptions(),
      );

      final result = await callable.call(data);
      final List<dynamic> resultList = jsonDecode(result.data.toString());
      final List<ResultModel> resultModels =
          resultList.map((e) => ResultModel.fromJson(e)).toList();
      unawaited(_firestoreService.saveResults(uid, resultModels));
      return resultModels;
    } catch (e) {
      debugPrint('Error calling function: $e');
      rethrow;
    }
  }

  Future<void> saveResultToFavorites(String uid, ResultModel result) {
    try {
      return _firestoreService.saveResultToFavorites(uid, result);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ResultModel>> getFavorites(String uid) {
    try {
      return _firestoreService.getFavorites(uid);
    } catch (e) {
      rethrow;
    }
  }

  // get all results
  Stream<List<ResultModel>> getResultsHistory(String uid) {
    try {
      return _firestoreService.getResultsHistory(uid);
    } catch (e) {
      rethrow;
    }
  }
}
