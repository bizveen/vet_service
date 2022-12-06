class OldPet {
  OldPet({
      this.addedBy, 
      this.barcode, 
      this.birthYear, 
      this.birthday, 
      this.breed, 
      this.client, 
      this.dateTime, 
      this.gender, 
      this.image, 
      this.key, 
      this.knowBirthday, 
      this.knowFather, 
      this.knowMother, 
      this.petName, 
      this.remainingPuppies, 
      this.sastVisitedDate, 
      this.status, 
      this.user,});

  OldPet.fromJson(dynamic json) {
    addedBy = json['addedBy'];
    barcode = json['barcode'];
    birthYear = json['birthYear'];
    birthday = json['birthday'];
    breed = json['breed'];
    client = json['client'];
    dateTime = json['dateTime'];
    gender = json['gender'];
    image = json['image'];
    key = json['key'];
    knowBirthday = json['knowBirthday'];
    knowFather = json['knowFather'];
    knowMother = json['knowMother'];
    petName = json['petName'];
    remainingPuppies = json['remainingPuppies'];
    sastVisitedDate = json['sastVisitedDate'];
    status = json['status'];
    user = json['user'];
  }
  String ? addedBy;
  String ? barcode;
  String ? birthYear;
  String ? birthday;
  String ? breed;
  String ? client;
  String ? dateTime;
  String ? gender;
  String ? image;
  String ? key;
  String ? knowBirthday;
  String ? knowFather;
  String ? knowMother;
  String ? petName;
  String ? remainingPuppies;
  String ? sastVisitedDate;
  String ? status;
  String ? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['addedBy'] = addedBy;
    map['qrCode'] = barcode;
    map['birthYear'] = birthYear;
    map['birthDay'] = birthday;
    map['breed'] = breed;
    map['client'] = client;
    map['dateTime'] = dateTime;
    map['gender'] = gender;
    map['image'] = image;
    map['key'] = key;
    map['knowBirthDay'] = knowBirthday;
    map['knowFather'] = knowFather;
    map['knowMother'] = knowMother;
    map['name'] = petName;
    map['remainingPuppies'] = remainingPuppies;
    map['sastVisitedDate'] = sastVisitedDate;
    map['status'] = status;
    map['user'] = user;
    return map;
  }

}