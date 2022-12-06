import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../../constants.dart';
import '../../../models/client_model.dart';
import '../../../models/sale/Product.dart';
import '../../../models/sale/inventory_in.dart';
import '../../../resources/database_object_paths/other_paths.dart';
import '../../../resources/firebase_database_methods.dart';
import '../../../resources/firebase_storage_methods.dart';
import '../../../widgets/container_with_border.dart';
import '../../../widgets/date_picker_widget.dart';
import '../../../widgets/gf_button_widget.dart';
import '../../../widgets/image_picker_widget.dart';
import '../../../widgets/text_field_x.dart';
import 'search_product_widget.dart';




class InventoryInScreen extends StatefulWidget {

  int? petIndex;

  bool editMode;

  InventoryInScreen({
    Key? key,

    this.petIndex,
    this.editMode = false,
  }) : super(key: key);

  @override
  State<InventoryInScreen> createState() => _InventoryInScreenState();
}

class _InventoryInScreenState extends State<InventoryInScreen> {


  TextEditingController qtyController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController retailPriceController = TextEditingController();
  TextEditingController costController = TextEditingController();
  Uint8List? image;
  Product? product;
DateTime? date = DateTime.now();
  InventoryIn?  inventoryIn;
  @override
  void dispose() {
    super.dispose();
    qtyController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory In Screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            TextFieldX(
                controller: qtyController,
                label: 'Qty'),
            TextFieldX(controller: descriptionController,
                label: 'description'),
            TextFieldX(controller: costController,
                label: 'Cost'),
            TextFieldX(controller: retailPriceController,
                label: 'Retail Price'),


            SearchProductWidget(
                title: 'Search Product', onSelect: (value){
              product = value;
            }),
            DatePickerWidget(
                buttonText: 'Date', pickedDate: (value){}),

            ImagePickerWidget(pickedImage: (_image) {
              image = _image;

            }),
            ContainerWithBorder(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GFButtonWidget(
                    name: 'Save',
                    onPressed: () async {
                      if (widget.editMode) {
                        // pet = widget.client.pets![widget.petIndex!]!.copyWith(
                        //   name: petNameController.text.trim(),
                        //   breed: screenController.breed.value,
                        // );
                      } else {
                        String id = const Uuid().v1();
                         inventoryIn= InventoryIn(
                          id: id,

                          path: '$doctorPath/inventoryIn/$id',
                          qty: int.parse(qtyController.text.trim()),
                          costPerItem: int.parse(costController.text.trim()),
                          dateTime: date!.millisecondsSinceEpoch ,
                          description: descriptionController.text.trim(),
                          product: product,
                          retailPrice: int.parse(retailPriceController.text.trim()),
                          transaction: 'in_${product!.id!}',


                        );

                         if(image != null){
                           FirebaseStorageMethods().uploadImageToStorage(
                               oneImage: true,
                               title: 'GRN Image',
                               addressPaths: clientPaths(clientStatus: ClientStatus.real),
                               file: image!,
                               folderPath: '$doctorPath/products/$id');
                         }

                      }
                      await FirebaseDatabaseMethods().updateBatch({
                        inventoryIn!.path!: inventoryIn!.toJson(),
                      });
                      Get.back();
                      // await FirebaseFirestoreMethods().addPetDataToSearch(
                      //     clientId: widget.client.id!,
                      //     searchWords: widget.client.pets!
                      //         .map((e) => e!.name!)
                      //         .toList());

                      // await SalesMethods(clientId: widget.client.id!)
                      //     .createASale();
                      // DataSnapshot snap = await FirebaseDatabaseMethods()
                      //     .reference(path: widget.client.path!)
                      //     .get();
                      // ClientModel updatedClient = ClientModel.fromJson(
                      //     snap.value as Map<dynamic, dynamic>);
                      // if (image != null) {
                      //   FirebaseStorageMethods().uploadImageToStorage(
                      //       title: 'Pet Profile Image',
                      //       mainLocationPath: pet!.path!,
                      //       file: image!,
                      //       folderPath:
                      //       '${Get.find<GlobalLiveVariablesController>().currentDoctor}/clients/${widget.client.id}');
                      // }

                      // Get.to(ClientDetailsScreen(
                      //   client: updatedClient,
                      // ));
                    },
                  ),
                  GFButtonWidget(
                    onPressed: () {},
                    name: "Cancel",
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
