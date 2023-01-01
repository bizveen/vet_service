import 'package:equatable/equatable.dart';

/// comment : ""
/// contact : ""
/// id : ""
/// path : ""
/// quickComment : ""

class Contact extends Equatable {
  Contact({
    this.status,
      this.comment, 
      this.contactNumber,
      this.id, 
      this.path, 
      this.quickComment,
     this.clientId,
     this.clientName,
     this.address

  });

  Contact.fromJson(dynamic json) {
    comment = json['comment'];
    contactNumber = json['contactNumber'];
    clientName = json['clientName'];
    address = json['address'];
    clientId = json['clientId'];


    status = json['status'];
    id = json['id'];
    path = json['path'];
    quickComment = json['quickComment'];
  }
  String? status;
  String? comment;
  String? contactNumber;
  String? id;
  String? path;
  String? quickComment;
  String? clientName;
  String? address;
  String? clientId;
Contact copyWith({  String? comment,
  String? contact,
  String? id,
  String? status,
  String? path,
  String? quickComment,
  String? clientName,
  String? address,
  String? clientId,
}) => Contact(  comment: comment ?? this.comment,
  contactNumber: contact ?? contactNumber,
  id: id ?? this.id,
  status: status ?? this.status,
  path: path ?? this.path,
  quickComment: quickComment ?? this.quickComment,
  clientId: clientId ?? this.clientId,
  address: address ?? this.address,
  clientName: clientName?? this.clientName
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['comment'] = comment;
    map['contactNumber'] = contactNumber;
    map['id'] = id;
    map['path'] = path;
    map['status'] = status;
    map['quickComment'] = quickComment;
    map['clientName'] = clientName;
    map['address'] = address;
    map['clientId'] = clientId;
    return map;
  }

  @override
  List<Object?> get props => [contactNumber];

}