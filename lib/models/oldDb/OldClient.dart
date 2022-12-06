class OldClient {
  OldClient({
      this.area, 
      this.firstVisitDateTime, 
      this.key, 
      this.language, 
      this.name, 
      this.street,
    this.balancePayment
  });

   OldClient.fromJson(dynamic json) {
    area = json['area'];
    firstVisitDateTime = json['firstVisitDateTime'];
    key = json['key'];
    language = json['language'];
    name = json['name'];
    street = json['street'];
    balancePayment = json['balancePayment'];
  }
  String ? area;
  String ? firstVisitDateTime;
  String ? key;
  String ? language;
  String ? name;
  String ? street;
  String? balancePayment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['area'] = area;
    map['firstVisitDateTime'] = firstVisitDateTime;
    map['id'] = key;
    map['language'] = language;
    map['name'] = name;
    map['address'] = street;
    map['balancePayment'] = balancePayment;
    return map;
  }

}