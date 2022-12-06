class OldCallLog {
  OldCallLog({
      this.by, 
      this.callDateTime, 
      this.calledContactNumber, 
      this.client, 
      this.id, 
      this.logType, 
      this.pet, 
      this.quickComment, 
      this.vaccination,});

  OldCallLog.fromJson(dynamic json) {
    by = json['by'];
    callDateTime = json['callDateTime'];
    calledContactNumber = json['calledContactNumber'];
    client = json['client'];
    id = json['id'];
    logType = json['logType'];
    pet = json['pet'];
    quickComment = json['quickComment'];
    vaccination = json['vaccination'];
  }
  String ? by;
  String ? callDateTime;
  String ? calledContactNumber;
  String ? client;
  String ? id;
  String ? logType;
  String ? pet;
  String ? quickComment;
  String ? vaccination;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['by'] = by;
    map['callDateTime'] = callDateTime;
    map['calledContactNumber'] = calledContactNumber;
    map['client'] = client;
    map['id'] = id;
    map['logType'] = logType;
    map['pet'] = pet;
    map['quickComment'] = quickComment;
    map['vaccination'] = vaccination;
    return map;
  }

}