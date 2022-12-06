
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../resources/firebase_database_methods.dart';
import 'add_new_drug_screen.dart';

class DrugsSettings extends StatefulWidget {
  const DrugsSettings({Key? key}) : super(key: key);

  @override
  State<DrugsSettings> createState() => _DrugsSettingsState();
}

class _DrugsSettingsState extends State<DrugsSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drugs Settings'),
      ),
      body: SingleChildScrollView(
        child: FirebaseDatabaseDataTable(
          query: FirebaseDatabaseMethods().reference(
              path:
                  '$doctorPath/drugs'),
          columnLabels: const {
            'name': Text('Name'),
            'retailPrice': Text('Retail Price'),
            'cost': Text('Cost'),
            'supplier': Text('Supplier'),
            'description': Text('Description'),
          },
          rowsPerPage: 10,
          actions: [IconButton(onPressed: (){
            Get.to(()=>AddNewDrugScreen());
          }, icon: Icon(Icons.add))],
          canDeleteItems: true,
        ),
      ),
    );
  }
}
