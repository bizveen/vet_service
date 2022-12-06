
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../models/client_model.dart';
import '../../models/sale/inventory_out.dart';

enum SalesSub { vaccines, treatments, inventoryOut, others }

enum BillingStatus {bill, notBill}
List<String> salesPaths({
  String? clientId,
  SalesSub? salesSub,
  String? currentActiveCaseId,
  required ClientStatus clientStatus,
  required BillingStatus billingStatus,
}) {
  if (salesSub != null) {


        return [
          'sales/$currentActiveCaseId/${salesSub.name}',
          '$doctorPath/clients/${clientStatus.name}/$clientId/sales/$currentActiveCaseId/${salesSub.name}',
          'clients/${clientStatus.name}/$clientId/sales/$currentActiveCaseId/${salesSub.name}',
          '$doctorPath/sales/all',
          '$doctorPath/sales/dayByDay/${DateUtils.dateOnly(DateTime.now()).microsecondsSinceEpoch}/$currentActiveCaseId/${salesSub.name}',

        ];

        // return [
        //   'sales/$currentActiveCaseId/${salesSub.name}',
        //   '$doctorPath/clients/${clientStatus.name}/$clientId/sales/$currentActiveCaseId/${salesSub.name}',
        //   'clients/${clientStatus.name}/$clientId/sales/$currentActiveCaseId/${salesSub.name}',
        //   '$doctorPath/sales/all',
        //   '$doctorPath/sales/dayByDay/${DateUtils.dateOnly(DateTime.now()).microsecondsSinceEpoch}/$currentActiveCaseId/${salesSub.name}',
        //   'users/${FirebaseAuth.instance.currentUser!.uid}/ownSales/all/$currentActiveCaseId/${salesSub.name}',
        //   'users/${FirebaseAuth.instance.currentUser!.uid}/ownSales/dayByDay/${DateUtils.dateOnly(DateTime.now()).microsecondsSinceEpoch}/$currentActiveCaseId/${salesSub.name}',
        // ];
        // break;



  }
  //creating a sale
  //billing
switch (billingStatus){

  case BillingStatus.bill:
  return [
    'sales',
    '$doctorPath/sales/all',
    '$doctorPath/sales/dayByDay/${DateUtils.dateOnly(DateTime.now()).microsecondsSinceEpoch}',
    'users/${FirebaseAuth.instance.currentUser!.uid}/ownSales/all',
     'users/${FirebaseAuth.instance.currentUser!.uid}/ownSales/dayByDay/${DateUtils.dateOnly(DateTime.now()).microsecondsSinceEpoch}',
  ];
  break;
  case BillingStatus.notBill:
    return [
      'sales',
      '$doctorPath/sales/all',
      '$doctorPath/sales/dayByDay/${DateUtils.dateOnly(DateTime.now()).microsecondsSinceEpoch}',
      // 'users/${FirebaseAuth.instance.currentUser!.uid}/ownSales/all',
      //  'users/${FirebaseAuth.instance.currentUser!.uid}/ownSales/dayByDay/${DateUtils.dateOnly(DateTime.now()).microsecondsSinceEpoch}',
    ];
    break;
}



}

Map<String, dynamic> updateSalesSubJson(
    {required String clientId,
    required String currentActiveCaseId,
    List<String?>? variables,
    SalesSub? salesSub,
    String? salesSubId,
      required BillingStatus billingStatus,
      required ClientStatus clientStatus,
    required List<dynamic> json}) {
  return pathListToUpdatableMap(
    id: salesSubId!,
    variables: variables,
    pathList: salesPaths(
      billingStatus: billingStatus,
      clientStatus: clientStatus,
      clientId: clientId,
      currentActiveCaseId: currentActiveCaseId,
      salesSub: salesSub,
      //salesSubId: salesSubId
    ),
    updatingValue: json,
  );
}

Map<String, dynamic> updateSalesJson(
    {String? clientId,
    required String salesId,
    List<String?>? variables,
      required ClientStatus clientStatus,
       BillingStatus billingStatus = BillingStatus.notBill,
    required List<dynamic> json}) {
  return pathListToUpdatableMap(
    id: salesId,
    variables: variables,
    pathList: salesPaths(
      billingStatus: billingStatus,
      clientStatus: clientStatus,
      clientId: clientId,
      currentActiveCaseId: salesId,
      //salesSubId: salesSubId
    ),
    updatingValue: json,
  );
}
Map<String, dynamic> updateInventoryOuts({
  required String inventoryInId,
  required String  currentActiveCaseId,
  String ? clientId,
  required InventoryOut inventoryOut,
  required ClientStatus clientStatus,
}) {

    return {
      '$doctorPath/inventoryIn/$inventoryInId/inventoryOut/$currentActiveCaseId' : inventoryOut.toJson(),
      '$doctorPath/inventoryOut/$currentActiveCaseId/$inventoryInId' : inventoryOut.toJson(),
      '$doctorPath/clients/${clientStatus.name}/$clientId/sales/$currentActiveCaseId/inventoryOut/$inventoryInId' : inventoryOut.toJson(),
      '$doctorPath/sales/dayByDay/${DateUtils.dateOnly(DateTime.now()).microsecondsSinceEpoch}/$currentActiveCaseId/inventoryOut/$inventoryInId': inventoryOut.toJson(),
      '$doctorPath/sales/all/$currentActiveCaseId/inventoryOut/$inventoryInId': inventoryOut.toJson(),
      'clients/${clientStatus.name}/$clientId/sales/$currentActiveCaseId/inventoryOut/$inventoryInId' : inventoryOut.toJson(),
      'sales/$currentActiveCaseId/inventoryOut/$inventoryInId' : inventoryOut.toJson(),
     // 'users/${FirebaseAuth.instance.currentUser!.uid}/ownSales/dayByDay/${DateUtils.dateOnly(DateTime.now()).microsecondsSinceEpoch}/$currentActiveCaseId/inventoryOut/$inventoryInId' : inventoryOut.toJson(),
     // 'users/${FirebaseAuth.instance.currentUser!.uid}/ownSales/all/$currentActiveCaseId/inventoryOut/$inventoryInId' : inventoryOut.toJson(),
    };
}

