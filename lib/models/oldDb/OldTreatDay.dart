class OldTreatDay {
  OldTreatDay({
      this.charges, 
      this.drugsInj, 
      this.followupDate, 
      this.key, 
      this.nextDate, 
      this.refDoctor, 
      this.treatment,});

  OldTreatDay.fromJson(dynamic json) {
    charges = json['charges'];
    drugsInj = json['drugsInj'];
    followupDate = json['followupDate'];
    key = json['key'];
    nextDate = json['nextDate'];
    refDoctor = json['refDoctor'];
    treatment = json['treatment'];
  }
  String ? charges;
  String ? drugsInj;
  String ? followupDate;
  String ? key;
  String ? nextDate;
  String ? refDoctor;
  String ? treatment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['charges'] = charges;
    map['drugsInj'] = drugsInj;
    map['followupDate'] = followupDate;
    map['key'] = key;
    map['nextDate'] = nextDate;
    map['refDoctor'] = refDoctor;
    map['treatment'] = treatment;
    return map;
  }

}