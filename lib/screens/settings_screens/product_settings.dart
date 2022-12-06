
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../resources/firebase_database_methods.dart';
import 'add_new_product_screen.dart';

class ProductsSettings extends StatefulWidget {
  const ProductsSettings({Key? key}) : super(key: key);

  @override
  State<ProductsSettings> createState() => _ProductsSettingsState();
}

class _ProductsSettingsState extends State<ProductsSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Settings'),
      ),
      body: SingleChildScrollView(
        child: FirebaseDatabaseDataTable(


          query: FirebaseDatabaseMethods().reference(
              path:
                  '$doctorPath/products'),
          columnLabels: const {
            'name': Text('Name'),
            'category': Text('Category'),
            'brand': Text('Brand'),
            'supplier': Text('Supplier'),
            'description': Text('Description'),
          },
          rowsPerPage: 10,
          actions: [IconButton(onPressed: (){
            Get.to(()=>const AddNewProductScreen());
          }, icon: const Icon(Icons.add))],
          canDeleteItems: true,
        ),
      ),
    );
  }
}
