import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:uuid/uuid.dart';
import '../../constants.dart';
import '../../controllers/global_live_variables_controller.dart';
import '../../models/Pet.dart';
import '../../models/client_model.dart';
import '../../resources/database_object_paths/other_paths.dart';
import '../../resources/firebase_database_methods.dart';
import '../../resources/firebase_firestore_methods.dart';
import '../../resources/firebase_storage_methods.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../resources/sales_methods.dart';
import '../../utils/tiny_space.dart';
import '../../utils/utils.dart';
import '../../widgets/container_with_border.dart';
import '../../widgets/date_picker_widget.dart';

import '../../widgets/drop_down_list_from_database_screen.dart';
import '../../widgets/gf_button_widget.dart';
import '../../widgets/image_picker_widget.dart';
import '../../widgets/image_picker_widget_round.dart';
import '../../widgets/search_client_widget.dart';
import '../../widgets/text_field_x.dart';
import '../../widgets/toggle_button_widget.dart';
import '../add_client_detials_screen/add_client_screen.dart';
import '../authentication_screens/local_widgets/button_x.dart';
import 'addPetScreenController.dart';
import 'local_widgets/birth_day_input_widget.dart';

class AddPetScreen extends StatefulWidget {
  ClientModel? client;
  int? petIndex;
  Pet? pet;

  AddPetScreen({
    Key? key,
    this.client,
    this.petIndex,
    this.pet,
  }) : super(key: key);

  @override
  State<AddPetScreen> createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  final _formKey = GlobalKey<FormState>();
  late String? _clientId;
  AddPetScreenController screenController = Get.put(AddPetScreenController());
  TextEditingController petNameController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController breedController = TextEditingController();
  TextEditingController qrController = TextEditingController();

  //TextEditingController breedController = TextEditingController();
  Uint8List? image;
  Pet? _pet;
  DateTime? birthDay;
  String gender = 'male';
  bool isMale = true;
  List<bool> toggleButtonSelections = [false, false];
  String petSearchIndex = '';
  String qrCode = '';
  ClientModel? clientModel;

  bool _validator() {
    if (_clientId == null) {
      showToast(message: 'Client field must be filled');
      return false;
    }
    if (screenController.breed.value == 'Not Selected') {
      showToast(message: 'Breed must be filled');
      return false;
    }
    return _formKey.currentState!.validate();
  }

  @override
  void dispose() {
    super.dispose();
    petNameController.dispose();
    searchController.dispose();
    qrController.dispose();
  }

  @override
  void initState() {
    if( widget.client!=null){
      _clientId = widget.client!.id!;
    }

    _pet = widget.pet;
    if (widget.pet != null) {
      if (widget.pet!.breed != null) {
        screenController.breed.value = widget.pet!.breed!;
      }

      if (widget.pet!.name != null) {
        petNameController.value = TextEditingValue(text: widget.pet!.name!);
      }
      if (widget.pet!.birthDay != null) {
        birthDay = DateTime.fromMicrosecondsSinceEpoch(widget.pet!.birthDay!);
      }
      if (widget.pet!.birthDay != null) {
        gender = widget.pet!.gender!;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Pet Screen'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(

                 onPressed: () {
                   Get.to(()=>AddClientScreen(getClient: (client){
                     setState((){
                       clientModel = client;
                       _clientId = client.id;
                     });

                   }));
                 }, child: Text(widget.client!= null ? widget.client!.name! : "Add Client"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Pet',
                  style: Get.textTheme.headline5,
                ),
              ),
              Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ImagePickerWidgetRound(
                              pickedImage: (_image) {
                                image = _image;
                              },
                              runningImage: image),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFieldX(
                                  controller: petNameController,
                                  label: 'Pet Name'),
                              ContainerWithBorder(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('Birth Day'),
                                    DatePickerWidget(
                                        buttonText: 'BirthDay',
                                        pickedDate: (date) {
                                          birthDay = date;
                                        },
                                        defaultDateTime: widget.pet == null
                                            ? DateTime.now()
                                            : DateTime
                                                .fromMicrosecondsSinceEpoch(
                                                    widget.pet!.birthDay!)),
                                  ],
                                ),
                              ),
                              ContainerWithBorder(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text('Breed'),
                                      TinySpace(),
                                      Obx(() {
                                        return GFButtonWidget(
                                          name: screenController
                                              .breed.value.toTitleCase!,
                                          onPressed: () {
                                            Get.to(
                                                DropDownListFromDatabaseScreen(
                                                    hintText: 'Search Breed',
                                                    onSelect: (value) {
                                                      screenController
                                                          .breed.value = value!;
                                                    },
                                                    notSelectedDialogText:
                                                        'Do you want to add this value to database?',
                                                    onConfirm: (value) {
                                                      screenController
                                                          .breed.value = value;
                                                    },
                                                    databasePath:
                                                        '$doctorPath/breeds',
                                                    databaseVariable: 'name'));
                                          },
                                        ); // Text(screenController.breed.value.toTitleCase!));
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                              ContainerWithBorder(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text('Gender'),
                                      TinySpace(),
                                      GFButtonWidget(
                                        color: isMale
                                            ? Theme.of(context).primaryColor
                                            : Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.5),
                                        onPressed: () {
                                          setState(() {
                                            isMale = !isMale;
                                          });
                                        },
                                        name: isMale ? 'Male' : "Female",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: TextFieldX(
                                      label: 'QR Code',
                                      controller: qrController,
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            value == '-1' ||
                                            value == 'Error') {
                                          return 'QR Code Required';
                                        }
                                      },
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        String code = '';
                                        String barcodeScanRes;
                                        qrController.clear();
                                        // Platform messages may fail, so we use a try/catch PlatformException.
                                        try {
                                          barcodeScanRes =
                                              await FlutterBarcodeScanner
                                                  .scanBarcode(
                                                      '#ff6666',
                                                      'Cancel',
                                                      true,
                                                      ScanMode.QR);
                                          setState(() {
                                            qrController.value =
                                                TextEditingValue(
                                                    text: qrCode == '-1'
                                                        ? 'Error'
                                                        : qrCode);
                                            qrCode = barcodeScanRes;
                                          });
                                        } on PlatformException {
                                          barcodeScanRes =
                                              'Failed to get platform version.';
                                        }

                                        // If the widget was removed from the tree while the asynchronous platform
                                        // message was in flight, we want to discard the reply rather than calling
                                        // setState to update our non-existent appearance.
                                        if (!mounted) {
                                          return;
                                        }
                                      },
                                      icon: const Icon(Icons.qr_code)),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonX(
                      text: 'Save',
                      onTap: () async {
                        if (_validator()) {
                          if (widget.pet != null) {
                          } else {
                            String id =
                                '${dateTimeDescender(dateTime: DateTime.now())}';
                            _pet = Pet(
                                id: _pet != null ? _pet?.id! : id,
                                clientId: _clientId,
                                name: petNameController.text.trim(),
                                breed: screenController.breed.value,
                                gender: isMale ? 'male' : 'female',
                                birthDay: birthDay != null
                                    ? birthDay!.microsecondsSinceEpoch
                                    : null,
                                doctorId: doctorId,
                                qrCode: qrController.text.trim(),
                                status: 'normal');
                          }

                          await FirebaseFirestoreMethods().updateClientValues(
                              clientId: _pet!.clientId!,
                              relativePath: 'pets.${_pet!.id!}',
                              json: _pet!.toJson());
                          // await SalesMethods(
                          //     clientId: _client!.id!,
                          //     clientStatus: ClientStatus.real)
                          //     .createASale();
                          // DataSnapshot snap =
                          // await FirebaseDatabaseMethods()
                          //     .reference(
                          //     path: clientPaths(
                          //         clientStatus:
                          //         ClientStatus.real)[0])
                          //     .get();
                          // ClientModel updatedClient = ClientModel.fromJson(
                          //     snap.value as Map<dynamic, dynamic>);
                          if (image != null) {
                            FirebaseStorageMethods().uploadImageToStorage(
                                title: 'Pet Profile Image',
                                addressPaths: petPaths(clientId: _clientId!)
                                    .map((e) => '$e/${_pet!.id}')
                                    .toList(),
                                file: image!,
                                folderPath: 'pets/${_pet!.id}');
                          }
                          Get.back();
                        }
                      },
                    ),
                    ButtonX(
                      onTap: () {
                        Get.back();
                      },
                      text: "Cancel",
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          String id =
                              '${dateTimeDescender(dateTime: DateTime.now())}';
                          _pet = Pet(
                              id: _pet != null ? _pet?.id! : id,
                              clientId: _clientId!,
                              name: petNameController.text.trim(),
                              breed: screenController.breed.value,
                              gender: isMale ? 'male' : 'female',
                              birthDay: birthDay != null
                                  ? birthDay!.microsecondsSinceEpoch
                                  : null,
                              doctorId: doctorId,

                              qrCode: qrController.text.trim(),

                              status: 'normal');
                          // FirebaseFirestoreMethods().addPetToFirestore(_pet!);
                        },
                        child: Text('Test Firestore'))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox clientSearchWidget() {
    return SizedBox(
      height: 100,
      child: Card(
        child: Row(
          children: [

            Container(
              color: Get.theme.primaryColor,
              child: Center(
                child: IconButton(
                  icon: Icon(Icons.add,
                      color: Get.theme.backgroundColor, size: 30),
                  onPressed: () {
AddClientScreen(getClient: (client){
  setState((){
    clientModel = client!;
  });

},);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
