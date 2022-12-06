import '../Image_model.dart';
import 'Product.dart';

class InventoryOut {
  InventoryOut({
    this.dateTime,
    this.description,
    this.id,
    this.product,
    this.qty,
    this.retailPrice,
    this.transaction,
  });

  InventoryOut.fromJson(dynamic json) {
    dateTime = json['dateTime'];
    description = json['description'];
    id = json['id'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    qty = json['qty'];
    retailPrice = json['retailPrice'];
    transaction = json['transaction'];
  }

  int? dateTime;
  String? description;
  String? id;
  Product? product;
  int? qty;
  int? retailPrice;
  String? transaction;

  InventoryOut copyWith({
    int? costPerItem,
    int? dateTime,
    String? description,
    String? id,
    String? path,
    ImageModel? image,
    Product? product,
    int? qty,
    int? retailPrice,
    String? supplier,
    String? transaction,
  }) =>
      InventoryOut(
        dateTime: dateTime ?? this.dateTime,
        description: description ?? this.description,
        id: id ?? this.id,
        product: product ?? this.product,
        qty: qty ?? this.qty,
        retailPrice: retailPrice ?? this.retailPrice,
        transaction: transaction ?? this.transaction,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dateTime'] = dateTime;
    map['description'] = description;
    map['id'] = id;
    if (product != null) {
      map['product'] = product?.toJson();
    }
    map['qty'] = qty;
    map['retailPrice'] = retailPrice;
    map['transaction'] = transaction;
    return map;
  }
}

/// id : "sdasdasd"
/// name : "dasdas"
