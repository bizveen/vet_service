
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/badge/gf_badge.dart';
import 'package:string_extensions/string_extensions.dart';
import '../models/Pet.dart';
import '../resources/firebase_database_methods.dart';
import '../screens/view_details_screens/view_client_details_screen/view_client_details_screen.dart';
import '../screens/view_details_screens/view_pet_details_screen/view_pet_details_screen.dart';
import 'pet_record_card/pet_record_card_widget.dart';

class PetCard extends StatefulWidget {
  Pet pet;
   PetCard({Key? key , required this.pet}) : super(key: key);

  @override
  State<PetCard> createState() => _PetCardState();
}

class _PetCardState extends State<PetCard> {
  @override
  Widget build(BuildContext context) {
    return
    //   ListTile(
    //   onTap: (){
    //     Get.to(ViewClientDetailsScreen(clientId: widget.pet.clientId! , petId: widget.pet.id,));
    //   },
    //   title: Text(widget.pet.name!),
    //   subtitle: Text(widget.pet.clientName!),
    // );
    PetRecordCardWidget(
      title:widget.pet.name!.toTitleCase! ,
      leading: const Padding(
        padding: EdgeInsets.all(8.0),
        child: GFBadge(),
      ),
      onAddButtonPressed: () async{

        Get.to(ViewPetDetailsScreen(
          client:  await FirebaseDatabaseMethods().getClientFromID(id: widget.pet.clientId!),
          petId:widget.pet.id! ,
        ));
      },
      onArrowButtonPressed: (){
        Get.to(ViewClientDetailsScreen(clientId: widget.pet.clientId!));
      },
      showAddButton: true,
      child: Column(
        children: [
          Text(widget.pet.breed!),

        ],
      ),
    );
  }
}
