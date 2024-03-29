

import 'package:flutter/material.dart';

import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';

import 'package:vet_service/screens/search_screens/client_search_screen.dart';
import '../../constants.dart';
import '../../models/Pet.dart';
import '../../resources/firebase_database_methods.dart';
import '../add_pet_screen/add_pet_screen.dart';
import '../search_screens/contact_search_screen.dart';
import '../search_screens/qr_search_screen.dart';
import 'drawer_widger.dart';
import 'local_widgets/pet_card_in_main_screen.dart';


class PetListScreen extends StatefulWidget {
  const PetListScreen({Key? key}) : super(key: key);

  @override
  State<PetListScreen> createState() => _PetListScreenState();
}

class _PetListScreenState extends State<PetListScreen> {


  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(title: const Text('Pets')
            ,

            actions: [

          IconButton(
              onPressed: () {
                Get.to(ContactSearchScreen());
              },
              icon: const Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    Get.to(ClientSearchScreen());
                  },
                  icon: const Icon(Icons.safety_check)),
          IconButton(
              onPressed: () {
                Get.to(QrSearchScreen());
              },
              icon: const Icon(Icons.qr_code)),

        ]),
        drawer: DrawerWidget(),
        body: FirebaseDatabaseListView(
          pageSize: 5,
          shrinkWrap: true,

           //  cacheExtent: 5,

                query: FirebaseDatabaseMethods()
                    .reference(path: '$doctorPath/pets/'),
                itemBuilder: (context, snapshot) {
                  Pet pet = Pet.fromJson((snapshot.value));

                  return PetCardInMainScreen(pet: pet);
                },
              )
           ,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
Get.to(()=>AddPetScreen());

        }, child: Text('+ Pet'),
      ),
        );
  }
}
