

import 'package:get/get.dart';
import '../Image_model.dart';
import 'Product.dart';
import 'inventory_out.dart';
class InventoryIn {
  InventoryIn({

      this.costPerItem, 
      this.dateTime, 
      this.description, 
      this.id, 
      this.path, 
      this.product, 
      this.qty, 
      this.retailPrice, 
      this.supplier, 
      this.transaction,
  this.image,
    this.inventoryOut,
  });

  InventoryIn.fromJson(dynamic json) {
    costPerItem = json['costPerItem'];
    dateTime = json['dateTime'];
    description = json['description'];
    id = json['id'];
    path = json['path'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
    image = json['image'] != null ? ImageModel.fromJson(json['image']) : null;
    qty = json['qty'];
    retailPrice = json['retailPrice'];
    supplier = json['supplier'];
    transaction = json['transaction'];

    List<InventoryOut> _inventoryOutList = [];

   if( json['inventoryOut'] != null){
     Map<dynamic, dynamic> _map = json['inventoryOut'] as Map<dynamic, dynamic>;

     _map.forEach(
           (key, element) {
             _inventoryOutList.add(InventoryOut.fromJson(element));
       },
     );
   }
inventoryOut = _inventoryOutList;
  }
  int? costPerItem;
  int? dateTime;
  ImageModel? image;
  String? description;
  String? id;
  String? path;
  Product? product;
  int? qty;
  int? retailPrice;
  String? supplier;
  String? transaction;
  List<InventoryOut?>? inventoryOut;
InventoryIn copyWith({  int? costPerItem,
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
}) => InventoryIn(  costPerItem: costPerItem ?? this.costPerItem,
  dateTime: dateTime ?? this.dateTime,
  description: description ?? this.description,
  id: id ?? this.id,
  path: path ?? this.path,
  product: product ?? this.product,
  qty: qty ?? this.qty,
  retailPrice: retailPrice ?? this.retailPrice,
  supplier: supplier ?? this.supplier,
  transaction: transaction ?? this.transaction,
  image: image  ?? this.image,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['costPerItem'] = costPerItem;
    map['dateTime'] = dateTime;
    map['description'] = description;
    map['id'] = id;
    map['path'] = path;
    if (product != null) {
      map['product'] = product?.toJson();
    }
    if (image != null) {
      map['image'] = product?.toJson();
    }
    map['qty'] = qty;
    map['retailPrice'] = retailPrice;
    map['supplier'] = supplier;
    map['transaction'] = transaction;
    return map;
  }
  int getRemainingQty (){

    if(inventoryOut==null || inventoryOut!.isEmpty){
      return qty!;} else{

      int outQty =0;
          inventoryOut!.forEach((element) {outQty= outQty+element!.qty!;
            Get.log(outQty.toString());
          });
          return qty!-outQty;
    }
  }

}

/// id : "sdasdasd"
/// name : "dasdas"

