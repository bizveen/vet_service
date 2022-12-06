
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../constants.dart';
import '../../models/sale/Product.dart';
import '../../resources/firebase_database_methods.dart';
import '../../widgets/text_field_x.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({Key? key}) : super(key: key);

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController supplierController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {

    super.dispose();
    productNameController.dispose();
    brandController.dispose();
    categoryController.dispose();
    supplierController.dispose();
    descriptionController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFieldX(label: 'Product Name' , controller:  productNameController,),
            TextFieldX(label: 'Brand' , controller: brandController,),
            TextFieldX(label: 'Category' , controller:  categoryController,),
            TextFieldX(label: 'Description', controller: descriptionController,),
            TextFieldX(label: 'Supplier' , controller: supplierController,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: ()async{
                  String id = Uuid().v1();
                  Product product = Product(
                    path: '$doctorPath/products/$id',
                    id: id,
                    name: productNameController.text.trim(),
                    brand: brandController.text.trim(),
                    description: descriptionController.text.trim(),
                    category: categoryController.text.trim(),
                    supplier: supplierController.text.trim(),

                  );

                  FirebaseDatabaseMethods().updateBatch({
                    product.path! : product.toJson()
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

