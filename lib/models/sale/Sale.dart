
import '../Vaccine.dart';
import '../complain/Treatment.dart';
import 'Service.dart';
import 'Shopping.dart';
import 'inventory_in.dart';
import 'inventory_out.dart';

/// clientPath : "dsdfsdfsd"
/// closedBy : "fsdfsdfsd"
/// dateTime : 4545445
/// discount : 4545.5
/// id : "sdad"
/// isActive : true
/// path : "dasdsd"
/// payment : 4454545.5
/// price : 4545.5
/// service : {"id":"sdsdasd"}
/// shop : {"id":"sdass"}
/// startedBy : "dfsfdsdfsfd"
/// treatment : {"id":"xczxxczx"}
/// type : "vaccination"
/// vaccination : {"id":"sdasd"}

class Sale {
  Sale({
    required this.clientStatus,
    this.clientId,
    this.closedBy,
    this.dateTime,
    this.discount,
    this.id,
    this.isActive,
    this.path,
    this.payment,
    this.price,
    this.balance,
    this.servicesList,
    this.inventoryOutList,
    this.startedBy,
    this.treatmentList,
    this.type,
    this.vaccineList,

  });

  Sale.fromJson(dynamic json) {
    clientId = json['clientId'];
    closedBy = json['closedBy'];
    dateTime = json['dateTime'];
    clientStatus = json['clientStatus'];
    discount = double.parse(
        (json['discount'] == '' ? '0' : json['discount'] ?? '0').toString());
    id = json['id'];
    balance = double.parse(
        (json['balance'] == '' ? '0' : json['balance'] ?? '0').toString());
    isActive = json['isActive'];
    path = json['path'];
    payment = double.parse(
        (json['payment'] == '' ? '0' : json['payment'] ?? '0').toString());
    price = json['price'];
    startedBy = json['startedBy'];
    type = json['type'];

    List<Service> _serviceList = [];
    if (json['services'] != null) {
      Map<dynamic, dynamic> _map = json['services'] as Map<dynamic, dynamic>;
      _map.forEach(
        (key, element) {
          _serviceList.add(Service.fromJson(element));
        },
      );
      servicesList = _serviceList;
    }


    List<InventoryOut> _productList = [];
    if (json['inventoryOut'] != null) {
      Map<dynamic, dynamic> _map =
          json['inventoryOut'] as Map<dynamic, dynamic>;
      _map.forEach(
        (key, element) {
          _productList.add(InventoryOut.fromJson(element));
        },
      );
      inventoryOutList = _productList;
    }


    List<Treatment> _treatmentList = [];
    if (json['treatments'] != null) {
      Map<dynamic, dynamic> _map = json['treatments'] as Map<dynamic, dynamic>;
      _map.forEach(
        (key, element) {
          _treatmentList.add(Treatment.fromJson(element));
        },
      );
      treatmentList = _treatmentList;
    }


    List<Vaccines> _vaccineList = [];
    if (json['vaccines'] != null) {
      Map<dynamic, dynamic> _map = json['vaccines'] as Map<dynamic, dynamic>;
      _map.forEach(
        (key, element) {
          _vaccineList.add(Vaccines.fromJson(element));
        },
      );
      vaccineList = _vaccineList;
    }

  }

  String? clientId;
  String? closedBy;
  int? dateTime;
  double? discount;
  String? id;
  bool? isActive;
  String? path;
  double? payment;
  double? balance;
  double? price;
  List<Service?>? servicesList;
  List<InventoryOut?>? inventoryOutList;
  String? startedBy;
  List<Treatment?>? treatmentList;
  String? type;
  List<Vaccines?>? vaccineList;
  int ? clientStatus;

   double totalChargesForVaccinations = 0;
   double totalChargesForTreatments = 0;
   double totalChargesForProducts = 0;


  Sale copyWith({
    String? clientId,
    String? closedBy,
    int? dateTime,
    double? discount,
    double? balance,
    String? id,
    bool? isActive,
    String? path,
    double? payment,
    double? price,
    List<Service?>? serviceList,
    List<InventoryOut?>? inventoryOutList,
    String? startedBy,
    List<Treatment?>? treatmentList,
    String? type,
    List<Vaccines?>? vaccineList,
    int ? clientStatus,
  }) =>
      Sale(
        clientId: clientId ?? this.clientId,
        closedBy: closedBy ?? this.closedBy,
        dateTime: dateTime ?? this.dateTime,
        discount: discount ?? this.discount,
        id: id ?? this.id,
        balance: balance ?? this.balance,
        isActive: isActive ?? this.isActive,
        path: path ?? this.path,
        payment: payment ?? this.payment,
        price: price ?? this.price,
        servicesList: serviceList ?? this.servicesList,
        inventoryOutList: inventoryOutList ?? this.inventoryOutList,
        startedBy: startedBy ?? this.startedBy,
        treatmentList: treatmentList ?? this.treatmentList,
        type: type ?? this.type,
        vaccineList: vaccineList ?? this.vaccineList,
        clientStatus: clientStatus ?? this.clientStatus,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['clientId'] = clientId;
    map['dateTime'] = dateTime;
    map['id'] = id;
    map['isActive'] = isActive;
    map['path'] = path;
    map['startedBy'] = startedBy;
    map['type'] = type;
    map['balance'] = balance;
    map['discount'] = discount;
    map['payment'] = payment;
    map['clientStatus'] = clientStatus;

    if(vaccineList!=null && vaccineList!.isNotEmpty){

      Map<String , dynamic> _map ={};
      vaccineList!.forEach(
              (element) {
            print(element!.toJson());}
      );
      vaccineList!.forEach(
              (element) {
                _map[element!.id!] = element.toJson();}
      );
      map['vaccines'] = _map;
    }
    if(treatmentList!=null && treatmentList!.isNotEmpty){
      Map<String , dynamic> _map ={};
      treatmentList!.forEach((element) { _map[element!.id!] = element.toJson();});
      map['treatments'] = _map;
    }
    if(inventoryOutList!=null && inventoryOutList!.isNotEmpty){
      Map<String , dynamic> _map ={};
      inventoryOutList!.forEach((element) { _map[element!.id!] = element.toJson();});
      map['inventoryOut'] = _map;
    }

    return map;
  }

  double getTotalChargesForVaccinations(){
    totalChargesForVaccinations = 0;
    if (vaccineList != null) {
      for (var element in vaccineList!) {
        if (element!.retailPrice.toString() != 'null' ||
            element.retailPrice != '') {

          totalChargesForVaccinations = totalChargesForVaccinations +
              double.parse(element.retailPrice.toString());
        }
      }
    }
    return totalChargesForVaccinations;
  }

  double getTotalChargesForTreatments(){
    totalChargesForTreatments = 0;
    if (treatmentList != null) {
      treatmentList?.forEach((element) {
        totalChargesForTreatments = totalChargesForTreatments +
            double.parse(element!.charges != null || element.charges != ''
                ? element.charges.toString()
                : '0');
      });
    }
return totalChargesForTreatments;
  }

double getTotalChargesForProducts() {
  totalChargesForProducts = 0;
  if (inventoryOutList != null) {
    for (var element in inventoryOutList!) {
      totalChargesForProducts = totalChargesForProducts +
          double.parse(
              element!.retailPrice != null || element.retailPrice != ''
                  ? element.retailPrice.toString()
                  : '0') *
              double.parse(element.qty.toString());
    }
  }
  return totalChargesForProducts;
}

  double getTotalCharges() {
    return (getTotalChargesForVaccinations() +
        getTotalChargesForTreatments() +
        getTotalChargesForProducts());
  }
}
