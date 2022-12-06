/// cost : ""
/// id : ""
/// isComplete : ""
/// paidAmount : ""
/// path : ""
/// price : ""
/// serviceId : ""
/// treatmentId : ""
/// type : ""
/// vaccineId : ""

class Purchasing {
  Purchasing({
      this.cost, 
      this.id, 
      this.isComplete, 
      this.paidAmount, 
      this.path, 
      this.price, 
      this.serviceId, 
      this.treatmentId, 
      this.type, 
      this.vaccineId,});

  Purchasing.fromJson(dynamic json) {
    cost = json['cost'];
    id = json['id'];
    isComplete = json['isComplete'];
    paidAmount = json['paidAmount'];
    path = json['path'];
    price = json['price'];
    serviceId = json['serviceId'];
    treatmentId = json['treatmentId'];
    type = json['type'];
    vaccineId = json['vaccineId'];
  }
  String? cost;
  String? id;
  String? isComplete;
  String? paidAmount;
  String? path;
  String? price;
  String? serviceId;
  String? treatmentId;
  String? type;
  String? vaccineId;
Purchasing copyWith({  String? cost,
  String? id,
  String? isComplete,
  String? paidAmount,
  String? path,
  String? price,
  String? serviceId,
  String? treatmentId,
  String? type,
  String? vaccineId,
}) => Purchasing(  cost: cost ?? this.cost,
  id: id ?? this.id,
  isComplete: isComplete ?? this.isComplete,
  paidAmount: paidAmount ?? this.paidAmount,
  path: path ?? this.path,
  price: price ?? this.price,
  serviceId: serviceId ?? this.serviceId,
  treatmentId: treatmentId ?? this.treatmentId,
  type: type ?? this.type,
  vaccineId: vaccineId ?? this.vaccineId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cost'] = cost;
    map['id'] = id;
    map['isComplete'] = isComplete;
    map['paidAmount'] = paidAmount;
    map['path'] = path;
    map['price'] = price;
    map['serviceId'] = serviceId;
    map['treatmentId'] = treatmentId;
    map['type'] = type;
    map['vaccineId'] = vaccineId;
    return map;
  }

}