
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../models/Pet.dart';
import '../../models/client_model.dart';
import '../../resources/firebase_database_methods.dart';
import '../../widgets/pet_card.dart';

class PetSearchScreen extends StatefulWidget {
  const PetSearchScreen({Key? key}) : super(key: key);

  @override
  State<PetSearchScreen> createState() => _PetSearchScreenState();
}

class _PetSearchScreenState extends State<PetSearchScreen> {
  TextEditingController searchController = TextEditingController();
  late String search;
  @override
  void initState() {
    search = searchController.text;
    super.initState();
  }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          TextFormField(
            controller: searchController,
            onChanged: (value){
              setState(() {
                search = value;
              });
            },
          ),
          Expanded(
            child: FirebaseDatabaseListView(
                query: FirebaseDatabaseMethods().reference(path: '$doctorPath/pets').orderByChild('name').startAt(search.toLowerCase()).endAt('${search.toLowerCase()}\uf8ff'),
                shrinkWrap: true,
                itemBuilder: (context, snapshot){
                  Pet pet = Pet.fromJson(snapshot.value);
                  return PetCard(pet: pet,);
                }),
          )
        ],
       
      ),
    );
  }
}
