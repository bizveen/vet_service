
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../constants.dart';
import '../../models/Contact.dart';
import '../../models/client_model.dart';
import '../../resources/database_object_paths/other_paths.dart';
import '../../resources/firebase_database_methods.dart';
import '../../resources/firebase_firestore_methods.dart';
import '../../resources/sales_methods.dart';
import '../../utils/tiny_space.dart';
import '../../widgets/contact_number_input_row.dart';
import '../../widgets/drop_down_list_from_database_screen.dart';
import '../../widgets/text_field_x.dart';
import 'add_client_screen_controller.dart';

class AddClientScreen extends StatefulWidget {

Function (ClientModel) getClient;
  AddClientScreen({Key? key , required this.getClient}) : super(key: key);

  @override
  State<AddClientScreen> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  TextEditingController clientNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  AddClientScreenController controller = Get.put(AddClientScreenController());
  int index = 0;
  final _formKey = GlobalKey<FormState>();

  List<TextEditingController> contactNoControllers = [
    TextEditingController(),
  ];
  List<Widget> contactNos = [];

  @override
  void dispose() {
    clientNameController.dispose();
    addressController.dispose();
    for (var element in contactNoControllers) {
      element.dispose();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Client')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TinySpace(),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text('Please fill your client details below'),
                  )),
              TinySpace(),
              TextFieldX(
                label: 'Client Name',
                controller: clientNameController,
                validator: (value){

                  if(value!.trim().isEmpty){
                    return 'Client Name must not be empty';
                  }

                },
              ),
              TextFieldX(
                label: 'Address',
                controller: addressController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Select Area ? '),
                  TextButton(
                    onPressed: () {
                      Get.to(DropDownListFromDatabaseScreen(
                          hintText: 'Select Area',
                          onSelect: (value) {
                            controller.area.value =
                                value ?? 'Not Selected the area';
                          },
                          notSelectedDialogText:
                              'Do you want to add this value to database?',
                          onConfirm: (value) {
                            controller.area.value = value;
                          },
                          databasePath: 'users/${doctorId}/areas',
                          databaseVariable: 'name'));
                    },
                    child: Obx(() {
                      return Text(controller.area.value);
                    }),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(contactNoControllers.length, (index) {
                  bool showPlusButton = false;
                  bool showMinusButton = true;
                  if (contactNoControllers.length == index + 1) {
                    showPlusButton = true;
                  }
                  if (contactNoControllers.length == 1) {
                    showMinusButton = false;
                  }
                  return ContactNoInputRow(
                      showMinusButton: showMinusButton,
                      showPlusButton: showPlusButton,
                      label: 'Contact Number ${index + 1}',
                      controller: contactNoControllers[index],
                      addPress: () {
                        setState(() {
                          contactNoControllers.add(TextEditingController());
                        });
                      },
                      removePress: () {
                        setState(() {
                          contactNoControllers.removeAt(index);
                        });
                      });
                }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () async{
                      if(  _formKey.currentState!.validate()){
                        widget.getClient( await _onSaveMethod());}

                      },
                      child: const Text('Save')),
                  ElevatedButton(
                      onPressed: () {
                        //Navigator.pop(context);
                        Get.back();
                      },
                      child: const Text('Cancel')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<ClientModel> _onSaveMethod() async {


    String id = const Uuid().v1();
    String activeCaseId = const Uuid().v1();
    List<Contact> contactList = [];
    String contactListForSearch = '';
    String nameForSearch =
        clientNameController.text.trim().replaceAll(' ', '####');

    contactListForSearch = contactListForSearch.trim().replaceAll(' ', '####');


    ClientModel clientModel = ClientModel(
      clientStatus: ClientStatus.real.index,
        currentActiveCaseId: activeCaseId,
        isActive: false,
        id: id,

        name: clientNameController.text.trim(),
        address: addressController.text.trim(),
        area: controller.area.value,
        pets: [],
        //contacts: contactList,
        doctorId: doctorId,
        searchIndex:
            '$id/%idBreak%/$nameForSearch/%nameBreak%/${controller.area.value}/%areaBreak%/$contactListForSearch/%pets%/');
    for (var element in contactNoControllers) {
      String contactId = const Uuid().v1();

      contactList.add(Contact(
          clientName: clientModel.name,
          id: contactId,
          path: 'users/${doctorId}/clients/$id/contacts/$contactId',
          contactNumber: element.text.trim()));
      contactListForSearch = contactListForSearch + ' ' + element.text.trim();
    }
   //  await FirebaseDatabaseMethods().updateBatch(
   // updateClientJson(clientStatus: ClientStatus.real,clientId: clientModel.id!, json: [clientModel.toJson()])
   //  );
    clientModel.contacts = contactList;
    print(clientModel.toJson());
    await FirebaseFirestoreMethods().addClientToFirestore(clientModel);
// contactList.forEach((element) async {
//   await FirebaseDatabaseMethods().updateBatch(
//       updateContactJson(clientId: clientModel.id!, json: [element.toJson()], contactId: element.id!)
//   );
//
// });

    await SalesMethods(clientId: clientModel.id, clientStatus: ClientStatus.real).createASale();

    // FirebaseFirestoreMethods().addClientToSearch(
    //     clientId: clientModel.id!,
    //     searchWords: clientModel.name!.toLowerCase().trim().split(' ') +
    //         contactList.map((e) => e.contactNo!).toList());
    //Navigator.pop(context);

   // Get.to(ClientDetailsScreen(client: clientModel));
    Get.back(canPop: false);
    return clientModel;
  }
}
