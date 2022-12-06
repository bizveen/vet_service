class OldContactNumber {
  OldContactNumber({
      this.client, 
      this.contactNumber, 
      this.key,});

  OldContactNumber.fromJson(dynamic json) {
    client = json['client'];
    contactNumber = json['contactNumber'].toString();
    key = json['key'].toString();
  }
  String? client;
  String? contactNumber;
  String? key;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['client'] = client;
    map['contactNumber'] = contactNumber;
    map['key'] = key;
    return map;
  }

}