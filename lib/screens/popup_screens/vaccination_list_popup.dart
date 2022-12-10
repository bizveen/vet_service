
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../models/Pet.dart';
import '../../utils/utils.dart';
import '../../widgets/pet_record_card/pet_record_card_widget.dart';
import '../vaccination_screens/add_vaccination_screen/add_vaccination_screen.dart';
import '../vaccination_screens/view_vaccination_details_screen.dart';

viewVaccinationList({required Pet pet}){
  pet.vaccinations!.sort((a, b) => b!.givenDate! - a!.givenDate!,);
  Get.defaultDialog(
      title: 'Vaccination Records (${pet.vaccinations!.length})',
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
              children: pet.vaccinations!.map((e) =>
                  PetRecordCardWidget(
                    title: e!.givenVaccine!.name!,
                    leading:
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.vaccines),
                    ),
                    showAddButton: false,
                    onAddButtonPressed: (){},
                    onArrowButtonPressed: (){
                      Get.to(ViewVaccinationDetailsScreen(vaccinationId: e.id!));
                    },
                    child: Column(
                      children: [
                        Text('Given Date : ${dateFormatter.format(DateTime.fromMicrosecondsSinceEpoch(e.givenDate!))}')
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