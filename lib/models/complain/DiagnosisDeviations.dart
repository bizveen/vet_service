import 'Disease.dart';

/// disease : {"id":"fgfg","path":"sdfsdf"}

class DiagnosisDeviations {
  DiagnosisDeviations({
      this.disease,});

  DiagnosisDeviations.fromJson(dynamic json) {
    disease = json['disease'] != null ? Disease.fromJson(json['disease']) : null;
  }
  Disease? disease;
DiagnosisDeviations copyWith({  Disease? disease,
}) => DiagnosisDeviations(  disease: disease ?? this.disease,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (disease != null) {
      map['disease'] = disease?.toJson();
    }
    return map;
  }

}