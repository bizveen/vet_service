class OldVaccination {
  OldVaccination({
      this.enteredDatetime, 
      this.followupStatus, 
      this.givenDate, 
      this.givenVaccine, 
      this.key, 
      this.nextDate, 
      this.nextDateAfter, 
      this.nextVaccine, 
      this.pet, 
      this.refDoctor,});

  OldVaccination.fromJson(dynamic json) {
    enteredDatetime = json['enteredDatetime'];
    followupStatus = json['followupStatus'];
    givenDate = json['givenDate'];
    givenVaccine = json['givenVaccine'];
    key = json['key'];
    nextDate = json['nextDate'];
    nextDateAfter = json['nextDateAfter'];
    nextVaccine = json['nextVaccine'];
    pet = json['pet'];
    refDoctor = json['refDoctor'];
  }
  String? enteredDatetime;
  String? followupStatus;
  String? givenDate;
  String? givenVaccine;
  String? key;
  String? nextDate;
  String? nextDateAfter;
  String? nextVaccine;
  String? pet;
  String? refDoctor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enteredDatetime'] = enteredDatetime;
    map['followupStatus'] = followupStatus;
    map['givenDate'] = givenDate;
    map['givenVaccine'] = givenVaccine;
    map['key'] = key;
    map['nextDate'] = nextDate;
    map['nextDateAfter'] = nextDateAfter;
    map['nextVaccine'] = nextVaccine;
    map['pet'] = pet;
    map['refDoctor'] = refDoctor;
    return map;
  }

}