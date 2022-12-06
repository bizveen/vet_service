import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';
import 'package:string_extensions/string_extensions.dart';

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


class ViewPetDetailsScreen extends StatefulWidget {
  String petId;
ClientModel client;
  ViewPetDetailsScreen({Key? key, required this.petId, required this.client}) : super(key: key);

  @override
  State<ViewPetDetailsScreen> createState() => _ViewPetDetailsScreenState();
}

class _ViewPetDetailsScreenState extends State<ViewPetDetailsScreen> {
  TextEditingController weightController = TextEditingController();
  DateTime date = DateTime.now();

  @override
  void dispose() {
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Uint8List? _image;
    int imageIndex = 0;

    return FirebaseDatabaseQueryBuilder(
      query: FirebaseDatabaseMethods().reference(path: 'pets/${widget.petId}'),
      pageSize: 100,
      builder: (context, snapshot, _) {
  
        if (snapshot.hasData) {
          Pet pet =
              Pet.fromJson(dataSnapShotListToMap(children: snapshot.docs));

          return Scaffold(
            appBar: AppBar(
              title:  Text((("${(pet.name!=null &&pet.name!= '') ? pet.name! :'Pet'}'s Details").toTitleCase!)),
              actions: [
                IconButton(
                    onPressed: () {
                      Get.to(EditPetDetailsScreen(petId: widget.petId));
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
                    ComplainCardWidget(pet: pet , client: widget.client,),
                    WeightCardWidget(pet: pet),
                    ElevatedButton(
                      child: Text('Go to Time Line Screen'),
                      onPressed: (){
                        Get.to(TimelineScreen(clientId: pet.clientId!, petId: pet.id!, ));
                      },
                    )

                  ],
                ),
              ),
            ),
          );
        } else {
          return Card(
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

