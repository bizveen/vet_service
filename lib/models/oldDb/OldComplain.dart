class OldComplain {
  OldComplain({
      this.callingStatus, 
      this.catogory, 
      this.key, 
      this.nextCallDate, 
      this.pet, 
      this.startedDateTime,
    this.comment
  });

  OldComplain.fromJson(dynamic json) {
    callingStatus = json['callingStatus'];
    catogory = json['catogory'];
    key = json['key'];
    nextCallDate = json['nextCallDate'];
    pet = json['pet'];
    startedDateTime = json['startedDateTime'];
    comment = json['comment'];
  }
  String ? callingStatus;
  String ? catogory;
  String ? key;
  String ? nextCallDate;
  String ? pet;
  String ? startedDateTime;
  String? comment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['callingStatus'] = callingStatus;
    map['catogory'] = catogory;
    map['id'] = key;
    map['nextCallingDate'] = nextCallDate;
    map['pet'] = pet;
    map['startedDateTime'] = startedDateTime;
    map['comment'] = comment;
    return map;
  }

}