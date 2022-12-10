import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/client_model.dart';

class ClientController  extends GetxController{

  Stream<ClientModel> getClientFromId(String clientId) {
    return FirebaseFirestore.instance
        .collection("clients").doc(clientId)
        .snapshots()
        .map((event) => ClientModel.fromJson(event.data()));
  }

  TextEditingController addNewNumberController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController balanceController = TextEditingController();


  @override
  void dispose() {
    addNewNumberController.dispose();
    commentController.dispose();
    balanceController.dispose();
    super.dispose();
  }

}