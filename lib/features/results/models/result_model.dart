class ResultModel {
  final String uid;
  final String painPoint;
  final int score;
  final bool? painkiller;
  final bool? saved;
  final String? suggestedSolution;
  final int? environmentalScore;

  const ResultModel({
    required this.uid,
    required this.painPoint,
    required this.score,
    this.painkiller,
    this.saved,
    this.suggestedSolution,
    this.environmentalScore,
  });

  //copyWith method
  ResultModel copyWith({
    String? uid,
    String? painPoint,
    int? score,
    bool? painkiller,
    bool? saved,
    String? suggestedSolution,
    int? environmentalScore,
  }) {
    return ResultModel(
      uid: uid ?? this.uid,
      painPoint: painPoint ?? this.painPoint,
      score: score ?? this.score,
      painkiller: painkiller ?? this.painkiller,
      saved: saved ?? this.saved,
      suggestedSolution: suggestedSolution ?? this.suggestedSolution,
      environmentalScore: environmentalScore ?? this.environmentalScore,
    );
  }

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      uid: json['uid'] as String,
      painPoint: json['pain_point'] as String,
      score: json['score'] as int,
      painkiller: json['painkiller'] as bool? ?? false,
      saved: json['saved'] as bool? ?? false,
      suggestedSolution: json['suggested_solution'] as String?,
      environmentalScore: json['environmental_score'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'pain_point': painPoint,
      'score': score,
      'painkiller': painkiller,
      'saved': saved,
      'suggested_solution': suggestedSolution,
      'environmental_score': environmentalScore,
    };
  }
}
