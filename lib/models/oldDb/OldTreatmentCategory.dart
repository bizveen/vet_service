class OldTreatmentCategory {
  OldTreatmentCategory({
      this.group, 
      this.id, 
      this.nextCallDate, 
      this.treatmentCatogory,});

  OldTreatmentCategory.fromJson(dynamic json) {
    group = json['group'];
    id = json['id'];
    nextCallDate = json['nextCallDate'];
    treatmentCatogory = json['treatmentCatogory'];
  }
  String? group;
  String? id;
  int? nextCallDate;
  String? treatmentCatogory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['group'] = group;
    map['id'] = id;
    map['nextCallDate'] = nextCallDate;
    map['treatmentCatogory'] = treatmentCatogory;
    return map;
  }

}