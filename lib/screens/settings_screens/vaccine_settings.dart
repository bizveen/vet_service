
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';
import 'package:vet_service/constants.dart';

import '../../controllers/global_live_variables_controller.dart';
import '../../resources/firebase_database_methods.dart';
import 'add_new_vaccine_screen.dart';

class VaccineSettings extends StatefulWidget {
  const VaccineSettings({Key? key}) : super(key: key);

  @override
  State<VaccineSettings> createState() => _VaccineSettingsState();
}

class _VaccineSettingsState extends State<VaccineSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vaccine Settings'),
      ),
      body: SingleChildScrollView(
        child: FirebaseDatabaseDataTable(
          query: FirebaseDatabaseMethods().reference(
              path:
                  '$doctorPath/vaccines'),
          columnLabels: const {
            'name': Text('Name'),
            'retailPrice': Text('Retail Price'),
            'cost': Text('Cost'),
            'supplier': Text('Supplier'),
            'description': Text('Description'),
          },
          rowsPerPage: 10,
          actions: [IconButton(onPressed: (){
            Get.to(()=>AddNewVaccineScreen());
          }, icon: Icon(Icons.add))],
          canDeleteItems: true,
        ),
      ),
    );
  }
}
