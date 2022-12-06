import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/Pet.dart';
import '../../models/Weight.dart';
import '../../resources/database_object_paths/other_paths.dart';
import '../../resources/firebase_database_methods.dart';
import '../../utils/utils.dart';
import '../../widgets/date_picker_widget.dart';

addWeightList({required Pet pet}){
  TextEditingController weightController = TextEditingController();
  DateTime date = DateTime.now();
  pet.allVaccinations!.sort((a, b) => b!.givenDate! - a!.givenDate!,);
  Get.defaultDialog(
      title: 'Add Weight',
      content: Column(
        children: [
          TextField(
            controller: weightController,
          ),
          DatePickerWidget(
              buttonText: 'Date',
              pickedDate: (value) {
                date = value;
              }),
        ],
      ),
      onConfirm: () async {
        Weight weight = Weight(
          date: date.microsecondsSinceEpoch,
          weight: weightController.text.trim(),
          id: dateTimeDescender(dateTime: DateTime.now())
              .toString(),
        );
        await FirebaseDatabaseMethods().updateBatch(
            updateWeightJson(
                petId: pet.id!,
                clientId: pet.clientId!,
                weightId: weight.id!,
                json: [weight.toJson()]));
        Get.back();
        weightController.dispose();
      });
}