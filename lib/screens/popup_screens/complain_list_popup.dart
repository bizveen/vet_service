
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../models/Pet.dart';
import '../../models/client_model.dart';
import '../../resources/database_object_paths/complain_paths.dart';
import '../../resources/firebase_database_methods.dart';
import '../../utils/utils.dart';
import '../../widgets/pet_record_card/pet_record_card_widget.dart';
import '../complain_screens/complain_details_screen.dart';
import '../vaccination_screens/add_vaccination_screen/add_vaccination_screen.dart';
import '../vaccination_screens/view_vaccination_details_screen.dart';

viewComplainList({required Pet pet}){

  Get.defaultDialog(
      title: 'Vaccination Records (${pet.allComplains!.length})',
onConfirm: (){
        Get.back();
},
      actions: [
        IconButton(
        icon: Icon(Icons.add),
          onPressed: (){
          Get.to(AddVaccinationScreen(pet: pet));
        },)
      ],
      content: SizedBox(
        height: Get.height*0.7,
        child: SingleChildScrollView(
          child: Container(
            color: Get.theme.backgroundColor.darken(),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: pet.allComplains!.map((e) =>
                  PetRecordCardWidget(
                    title: e!.getTitle(),
                    leading:
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.medication),
                    ),
                    showAddButton: false,
                    onAddButtonPressed: (){},
                    onArrowButtonPressed: ()async{
                      ClientModel client = await FirebaseDatabaseMethods().getClientFromID(id: e.clientID!);
                      Get.to(ComplainDetailsScreen(complain: e, client: client, complainStatus: ComplainStatus.all));
                    },
                    child: Column(
                      children: [
                        Text('Date : ${dateFormatter.format(DateTime.fromMicrosecondsSinceEpoch(e.startedDateTime!))}')
                      ],
                    ),
                  )
              ).toList(),
            ),
          ),
        ),
      )
  );
}