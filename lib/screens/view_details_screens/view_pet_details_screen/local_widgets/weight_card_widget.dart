
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/Pet.dart';
import '../../../../resources/firebase_database_methods.dart';
import '../../../../utils/tiny_space.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/pet_record_card/pet_record_card_widget.dart';
import '../../../chart_screens/weight_chart_screen.dart';
import '../../../popup_screens/add_weight_popup.dart';
import '../../../popup_screens/complain_list_popup.dart';
import '../../../vaccination_screens/add_vaccination_screen/add_vaccination_screen.dart';
import '../../../popup_screens/vaccination_list_popup.dart';


class WeightCardWidget extends StatefulWidget {
  Pet pet;

   WeightCardWidget({Key? key, required this.pet,}) : super(key: key);

  @override
  State<WeightCardWidget> createState() => _WeightCardWidgetState();
}

class _WeightCardWidgetState extends State<WeightCardWidget> {

  @override
  @override
  Widget build(BuildContext context) {
    return PetRecordCardWidget(

      leading: const Padding(
        padding: EdgeInsets.all(15.0),
        child: Icon(Icons.scale),
      ),
        onAddButtonPressed: () async {


       addWeightList(pet: widget.pet);

        },
        onArrowButtonPressed: (){
          Get.defaultDialog(
            content: WeightChartScreen(weightList: widget.pet.weight!,),
            onConfirm: (){
              Get.back();
            }
          );
        },
        title: 'Weight',
        child:(widget.pet.weight!= null && widget.pet.weight!.isNotEmpty) ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Last Weight',
              style: TextStyle(fontSize: 9),
            ),
           Row(
             children: [
               Text(
                 dateFormatter.format(DateTime.fromMicrosecondsSinceEpoch(
                     widget.pet.weight!.last!.date!)),
                 style: const TextStyle(fontSize: 11),
               ),
               TinySpace(),
               Text(widget.pet.weight!.last!.weight!),

             ],
           ),
          ],
        ):const Center(child: Text('No Weight Details'),)
    )  ;
  }


}