class OldBreed {
  OldBreed({
      this.breed, 
      this.group,});

  OldBreed.fromJson(dynamic json) {
    breed = json['breed'];
    group = json['group'];
  }
  String? breed;
  String? group;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['breed'] = breed;
    map['group'] = group;
    return map;
  }

}