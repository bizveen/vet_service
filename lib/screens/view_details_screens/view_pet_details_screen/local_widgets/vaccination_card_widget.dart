
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/Pet.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/pet_record_card/pet_record_card_widget.dart';
import '../../../vaccination_screens/add_vaccination_screen/add_vaccination_screen.dart';
import '../../../popup_screens/vaccination_list_popup.dart';


class VaccinationCardWidget2 extends StatefulWidget {
  Pet pet;
  bool isActiveClient;
   VaccinationCardWidget2({Key? key, required this.pet , required this.isActiveClient}) : super(key: key);

  @override
  State<VaccinationCardWidget2> createState() => _VaccinationCardWidget2State();
}

class _VaccinationCardWidget2State extends State<VaccinationCardWidget2> {

  @override
  @override
  Widget build(BuildContext context) {
    return PetRecordCardWidget(
      leading: const Padding(
        padding: EdgeInsets.all(15.0),
        child: Icon(Icons.vaccines),
      ),
        onAddButtonPressed: (){

        Get.to(AddVaccinationScreen(pet: widget.pet,isClientActive:  widget.isActiveClient, ));
        },
        onArrowButtonPressed: (){
          viewVaccinationList(pet: widget.pet , isClientActive: widget.isActiveClient);
        },
        title: 'Vaccinations',
        child:(widget.pet.vaccinations!= null && widget.pet.vaccinations!.isNotEmpty) ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Last Vaccine',
              style: TextStyle(fontSize: 9),
            ),
            Table(
              columnWidths: const {
                0: FixedColumnWidth(70),
                1: FixedColumnWidth(50),
                2: FixedColumnWidth(70),
              },
              children: [
                TableRow(
                  children: [
                    Text(
                      dateFormatter.format(DateTime.fromMicrosecondsSinceEpoch(
                          widget.pet.vaccinations!.first!.givenDate!)),
                      style: const TextStyle(fontSize: 11),
                    ),
                    Text(widget.pet.vaccinations!.first!.givenVaccine!.name!,
                        overflow: TextOverflow.ellipsis),
                    const Text(''),
                  ],
                ),
                TableRow(
                  children: [
                    const Text(
                      'Next',
                      style: TextStyle(fontSize: 11),
                    ),
                    Text(
                      widget.pet.vaccinations!.last!.nextVaccine!,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      dateFormatter.format(DateTime.fromMicrosecondsSinceEpoch(
                          widget.pet.vaccinations!.last!.nextDate!)),
                      style: const TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ):const Center(child: Text('No Vaccine Details'),)
    )  ;
  }


}