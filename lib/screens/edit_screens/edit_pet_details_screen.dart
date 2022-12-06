
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';

import '../../constants.dart';
import '../../models/Pet.dart';
import '../../models/client_model.dart';
import '../../resources/database_object_paths/other_paths.dart';
import '../../resources/firebase_database_methods.dart';
import '../../utils/utils.dart';
import '../../widgets/edit_widgets/edit_using_dropdown_list_widget.dart';
import '../../widgets/edit_widgets/edit_using_text_field_widget.dart';
import '../../widgets/pet_card2.dart';

class EditPetDetailsScreen extends StatefulWidget {
  String petId;
   EditPetDetailsScreen({Key? key, required this.petId}) : super(key: key);

  @override
  State<EditPetDetailsScreen> createState() => _EditPetDetailsScreenState();
}

class _EditPetDetailsScreenState extends State<EditPetDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return FirebaseDatabaseQueryBuilder(
      pageSize: 50,
      query: FirebaseDatabaseMethods().reference(path: 'pets/${widget.petId}'),
      builder: (context, snapshot, _) {
        Pet pet = Pet.fromJson(dataSnapShotListToMap(children: snapshot.docs));
        return Scaffold(
          appBar: AppBar(
            title: Text('Edit Pet Details'),
          ),
          body: Column(
            children: [
              EditUsingTextFieldWidget(
                id: pet.id!,
                  variable: 'name',
                  pathList: petPaths(clientId: pet.clientId!),
                  child: Text(pet.name!)),
              EditUsingDropdownListWidget(
                databaseListPath: '$doctorPath/breeds',
                  databaseListVariable: 'name',
                  hintText: 'Select Breed',
                  id: pet.id!,
                  variable: 'breed',
                  pathList: petPaths(clientId: pet.clientId!),
                  child: Text(pet.breed!)),


            ],
          ),
        );
      }
    );
  }
}
