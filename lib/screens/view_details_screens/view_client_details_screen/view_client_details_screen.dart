import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:uuid/uuid.dart';
import 'package:vet_service/resources/firebase_firestore_methods.dart';
import '../../../models/Contact.dart';
import '../../../models/client_model.dart';
import '../../../resources/database_object_paths/other_paths.dart';
import '../../../resources/firebase_database_methods.dart';
import '../../../resources/sales_methods.dart';
import '../../../utils/tiny_space.dart';
import '../../../utils/utils.dart';
import '../../../widgets/bill_widgets/total_bill_widget.dart';
import '../../../widgets/pet_card2.dart';
import '../../../widgets/pet_record_card/pet_record_card_widget.dart';
import '../../../widgets/text_field_x.dart';
import '../../add_pet_screen/add_pet_screen.dart';
import '../../edit_screens/edit_client_details_screen.dart';
import '../../logs_list_screen.dart';
import '../../shop_screens/products_showcase_screen.dart';
import '../view_pet_details_screen/view_pet_details_screen.dart';

class ViewClientDetailsScreen extends StatefulWidget {
  String clientId;
  String? petId;

  ViewClientDetailsScreen({Key? key, required this.clientId, this.petId})
      : super(key: key);

  @override
  State<ViewClientDetailsScreen> createState() =>
      _ViewClientDetailsScreenState();
}

class _ViewClientDetailsScreenState extends State<ViewClientDetailsScreen> {
  TextEditingController addNewNumberController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController balanceController = TextEditingController();
  late ClientModel _clientModel;

  @override
  void initState() {
    DocumentReference reference =
        FirebaseFirestore.instance.collection('clients').doc(widget.clientId);
    reference.snapshots().listen((querySnapshot) {
      setState(() {
        _clientModel =
            ClientModel.fromJson(querySnapshot.data() as Map<String, dynamic>);
      });
    });
    super.initState();
  }

  final formkey = GlobalKey<FormState>();

  Future<void> addNewContactNumber({
    required ClientModel client,
  }) async {
    await Get.defaultDialog(
        content: Column(
          children: [
            TextFieldX(label: 'New Number', controller: addNewNumberController),
            TextFieldX(label: 'Comment', controller: commentController),
          ],
        ),
        onConfirm: () async {
          Contact contact = Contact(
            id: Uuid().v1(),
            contactNumber: addNewNumberController.text.trim(),
            comment: commentController.text.trim(),
            clientId: client.id!,
            clientName: client.name,
            address: client.address,
          );
          await FirebaseDatabaseMethods().updateBatch(
            updateContactJson(
                clientId: contact.clientId!,
                json: [contact.toJson()],
                contactId: contact.id!),
          );
          Get.back();
        },
        onCancel: () {
          Get.back();
        });
  }

  @override
  void dispose() {
    addNewNumberController.dispose();
    commentController.dispose();
    balanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('clients').doc(widget.clientId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
                // appBar: AppBar(
                //   title: const Text('Loading...'),
                // ),
                body: Card(child: Center(child: CircularProgressIndicator())));
          }
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(),
              // appBar: AppBar(
              //   title: const Text('Loading...'),
              // ),
              body: Card(
                child: Text(
                  snapshot.error.toString(),
                ),
              ),
            );
          }

          ClientModel client = ClientModel.fromJson(snapshot.data as Map<String , dynamic>);

          return SafeArea(
            child: Builder(builder: (context) {
              return Scaffold(
                appBar: AppBar(
                  title: Text("${client.name ?? 'No Name'}'s Details"),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Get.to(EditClientDetailsScreen(
                            clientId: client.id!,
                          ));
                        },
                        icon: const Icon(Icons.edit))
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          clientHeader(client),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Pets',
                              style: Get.textTheme.headline5,
                            ),
                          ),
                          client.pets != null
                              ? petArea(client)
// Column(
//   children: client.pets!.map((e) => PetCard(pet: e!)).toList(),
// )
                              //return PetCard2(pet: client.pets![index]!);})
                              : const Center(
                                  child: Text('No Pets'),
                                ),
                          client.currentActiveCaseId != null
                              ? TotalBillWidgets(
                                  clientStatus: ClientStatus.real,
                                  saleId: client.currentActiveCaseId!)
                              : ElevatedButton(
                                  onPressed: () {
                                    SalesMethods(
                                            clientId: client.id,
                                            clientStatus: ClientStatus.real)
                                        .createASale();
                                  },
                                  child: const Text('Activate')),
                          ElevatedButton(
                              onPressed: () {
                                Get.to(ProductShowCaseScreen(
                                  clientModel: client,
                                  clientStatus: ClientStatus.real,
                                ));
                              },
                              child: const Text('Pet Shop')),
                          ElevatedButton(
                              onPressed: () {
                                Get.defaultDialog(
                                    title: 'Add a Balance',
                                    content: TextFormField(
                                      controller: balanceController,
                                      validator: (value) {
                                        if (value.isNumber) {
                                          return 'Please Enter a Number';
                                        }
                                      },
                                    ),
                                    onConfirm: () {
                                      formkey.currentState!.validate();
                                      if (balanceController.text
                                          .trim()
                                          .isNumber) {
                                        client.pets!.forEach((element) async {
                                          await FirebaseDatabaseMethods()
                                              .updateBatch(
                                            updatePetJson(
                                                petId: element!.id!,
                                                clientId: client.id!,
                                                json: [
                                                  balanceController.text.trim()
                                                ],
                                                variables: [
                                                  'balance'
                                                ])
                                              ..addAll(updateClientJson(
                                                  clientId: client.id!,
                                                  clientStatus:
                                                      ClientStatus.real,
                                                  json: [
                                                    balanceController.text
                                                        .trim()
                                                  ],
                                                  variables: [
                                                    'balance'
                                                  ])),
                                          );
                                        });
                                      }
                                    });
                              },
                              child: const Text('Add A Balance')),
                          PetRecordCardWidget(
                            title: 'Logs',
                            leading: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.pending_actions),
                            ),
                            onArrowButtonPressed: () {
                              Get.to(LogsListScreen(
                                logList: client.logs!,
                              ));
                            },
                            onAddButtonPressed: () {},
                            child: (client.logs != null &&
                                    client.logs!.isNotEmpty)
                                ? Expanded(
                                    child: Text(
                                      client.logs!.last!.comment!.toString(),
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                : Center(child: Text('No Logs')),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Get.to(LogsListScreen(
                                  logList: client.logs!,
                                ));
                              },
                              child: Text('Logs')),
                        ],
                      ),
                    ),
                  ),
                ),
                floatingActionButton: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton(
                        heroTag: 'Add Pet Button',
                        onPressed: () {
                          Get.to(() => AddPetScreen(
                                client: client,
                              ));
                        },
                        child: const Text(
                          'Add Pet',
                          textAlign: TextAlign.center,
                        )),
                  ],
                ),
              );
            }),
          );
        });
  }

  Card clientHeader(ClientModel client) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GFAvatar(
                  size: 50,
                  backgroundColor: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)],
                  child: Center(
                      child: Text(
                    client.name.first()!.toUpperCase(),
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Get.theme.backgroundColor),
                  )),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Tooltip(
                      message: client.name!,
                      child: SizedBox(
                        width: Get.width,
                        child: Text(
                          client.name!.toTitleCase!,
                          overflow: TextOverflow.ellipsis,
                          style: Get.theme.textTheme.headline4,
                        ),
                      ),
                    ),
                    Tooltip(
                      message: client.address,
                      child: Row(
                        children: [
                          const Icon(Icons.location_history),
                          TinySpace(),
                          Expanded(
                            child: Text(
                              client.address!,
                              style: Get.theme.textTheme.bodyText2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Tooltip(
                      message: client.area,
                      child: Row(
                        children: [
                          const Icon(Icons.maps_home_work_outlined),
                          TinySpace(),
                          Text(
                            client.area!.toTitleCase!,
                            style: Get.theme.textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
            const Icon(Icons.call, size: 30),
            ...client.contacts!
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Chip(
                      label: Text(e!.contactNumber!),
                    ),
                  ),
                )
                .toList()
              ..addAll([
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: InkWell(
                    onTap: () async {
                      await addNewContactNumber(client: client);
                    },
                    child: Chip(
                      backgroundColor: Get.theme.primaryColor.withOpacity(0.2),
                      label: const Text('+ Contact'),
                    ),
                  ),
                ),
              ])
          ]),
        ],
      ),
    );
  }

  Wrap petArea(ClientModel client) {
    return Wrap(
      children: client.pets!
          .map((e) => Container(
                height: 60,
                child: Card(
                  color: e!.isProperlyVaccinated()
                      ? Colors.red
                      : Get.theme.backgroundColor,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.pets),
                      ),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            e.name!.toTitleCase!,
                            style: Get.textTheme.headline6,
                          ),
                          Text(e.breed!.toTitleCase!),
                        ],
                      )),
                      Container(
                        color: Get.theme.primaryColor,
                        width: 50,
                        child: Center(
                          child: IconButton(
                            onPressed: () async {
                              Get.to(ViewPetDetailsScreen(
                                  petId: e.id!,
                                  client: await FirebaseDatabaseMethods()
                                      .getClientFromID(id: e.clientId!)));
                            },
                            icon: Icon(
                              Icons.arrow_circle_right_outlined,
                              color: Get.theme.backgroundColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }
}
