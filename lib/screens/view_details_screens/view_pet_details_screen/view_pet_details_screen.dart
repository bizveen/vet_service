import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:vet_service/controllers/client_controller.dart';

import '../../../models/Pet.dart';
import '../../../models/client_model.dart';
import '../../../resources/firebase_database_methods.dart';
import '../../../timeline_screen/timeline_screen.dart';
import '../../../utils/tiny_space.dart';
import '../../../utils/utils.dart';
import '../../edit_screens/edit_pet_details_screen.dart';
import 'local_widgets/complain_card_widget.dart';
import 'local_widgets/pet_header_card_widget.dart';
import 'local_widgets/vaccination_card_widget.dart';
import 'local_widgets/weight_card_widget.dart';


class ViewPetDetailsScreen extends GetWidget<ClientController> {

String clientId;
String petId;
  ViewPetDetailsScreen({Key? key, required this.clientId, required this. petId}) : super(key: key);


  TextEditingController weightController = TextEditingController();
  DateTime date = DateTime.now();

  // @override
  // void dispose() {
  //   weightController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Uint8List? _image;
    int imageIndex = 0;

          return StreamBuilder(
            stream: controller.getClientFromId(clientId),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return Card(child: Center(child: CircularProgressIndicator(),));
              }
              ClientModel client = snapshot.data as ClientModel;
              Pet pet = client.pets!.where((element) => element!.id! == petId).first!;
              return Scaffold(
                appBar: AppBar(
                  title:  Text((("${(pet.name!=null && pet.name!= '') ? pet.name! :'Pet'}'s Details").toTitleCase!)),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Get.to(EditPetDetailsScreen(petId: pet.id!));
                        },
                        icon: Icon(Icons.edit))
                  ],
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PetHeaderCard(pet: pet, image: _image),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Records', style: Get.textTheme.headline5,),
                        ),

                        //VaccinationListWidget(pet: pet),

                        VaccinationCardWidget2(pet: pet),
                        ComplainCardWidget(pet: pet , client: client,),
                        WeightCardWidget(pet: pet),
                        ElevatedButton(
                          child: Text('Go to Time Line Screen'),
                          onPressed: (){
                            Get.to(TimelineScreen(clientId: client.id!, petId: pet.id!, ));
                          },
                        )

                      ],
                    ),
                  ),
                ),
              );
            }
          );


  }
}

