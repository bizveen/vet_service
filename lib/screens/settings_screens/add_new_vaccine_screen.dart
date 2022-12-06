
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../constants.dart';
import '../../models/Vaccine.dart';
import '../../resources/firebase_database_methods.dart';
import '../../widgets/text_field_x.dart';

class AddNewVaccineScreen extends StatefulWidget {
  const AddNewVaccineScreen({Key? key}) : super(key: key);

  @override
  State<AddNewVaccineScreen> createState() => _AddNewVaccineScreenState();
}

class _AddNewVaccineScreenState extends State<AddNewVaccineScreen> {
  TextEditingController vaccineNameController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController retailPriceController = TextEditingController();
  TextEditingController supplierController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {

    super.dispose();
    vaccineNameController.dispose();
    costController.dispose();
    retailPriceController.dispose();
    supplierController.dispose();
    descriptionController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Vaccine'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFieldX(label: 'Vaccine Name' , controller:  vaccineNameController,),
            TextFieldX(label: 'Cost' , controller: costController,),
            TextFieldX(label: 'Retail Price' , controller:  retailPriceController,),
            TextFieldX(label: 'Description', controller: descriptionController,),
            TextFieldX(label: 'Supplier' , controller: supplierController,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: ()async{
                  String id = Uuid().v1();
                  Vaccines vaccine = Vaccines(
                    path: '$doctorPath/vaccines/$id',
                    id: id,
                    name: vaccineNameController.text.trim(),
                    cost: costController.text.trim(),
                    description: descriptionController.text.trim(),
                    retailPrice: retailPriceController.text.trim(),
                    supplier: supplierController.text.trim(),

                  );

                  FirebaseDatabaseMethods().updateBatch({
                    vaccine.path! : vaccine.toJson()
                  });
                  Get.back();
                }, child: const Text('Save')),
                ElevatedButton(onPressed: (){Get.back();}, child: const Text('Cancel')),
              ],
            )
          ],
        ),
      ),
    );
  }
}

