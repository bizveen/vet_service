
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/Pet.dart';
import '../../../../models/client_model.dart';
import '../../../../resources/database_object_paths/complain_paths.dart';
import '../../../../resources/firebase_database_methods.dart';
import '../../../../utils/tiny_space.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/pet_record_card/pet_record_card_widget.dart';
import '../../../complain_screens/add_complain_screen.dart';
import '../../../complain_screens/complain_details_screen.dart';
import '../../../popup_screens/complain_list_popup.dart';


class ComplainCardWidget extends StatefulWidget {
  Pet pet;
  ClientModel client;

   ComplainCardWidget({Key? key, required this.pet, required this.client}) : super(key: key);

  @override
  State<ComplainCardWidget> createState() => _ComplainCardWidgetState();
}

class _ComplainCardWidgetState extends State<ComplainCardWidget> {
bool complainLoading = false;
  @override
  @override
  Widget build(BuildContext context) {
    return PetRecordCardWidget(
      loadingState: complainLoading,
      leading: const Padding(
        padding: EdgeInsets.all(15.0),
        child: Icon(Icons.medical_information_outlined),
      ),
        onAddButtonPressed: () async {
        setState(() {
          complainLoading = true;
        });
          Map<dynamic, dynamic> map = await FirebaseDatabaseMethods()
              .getFirstExaminationCategories();
        Get.to(AddComplainScreen(pet: widget.pet, firstInspectionMap: map));
        setState(() {
          complainLoading = false;
        });
        },
        onArrowButtonPressed: (){
          viewComplainList(pet: widget.pet);
        },
        title: 'Complains',
        child:(widget.pet.complains!= null && widget.pet.complains!.isNotEmpty) ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Last Complain',
              style: TextStyle(fontSize: 9),
            ),
           Row(
             children: [
               Text(
                 dateFormatter.format(DateTime.fromMicrosecondsSinceEpoch(
                     widget.pet.complains!.last!.startedDateTime!)),
                 style: const TextStyle(fontSize: 11),
               ),
               TinySpace(),

               Expanded(child: Text(widget.pet.complains!.last!.getTitle(withPetName: false), overflow: TextOverflow.ellipsis,)),
               IconButton(onPressed: () async {
                 Get.to(ComplainDetailsScreen(
                     complainId: widget.pet.complains!.first!.id!,
                     clientId: widget.client.id!,
                     petId: widget.pet.id!,
                     complainStatus: ComplainStatus.all));
               }, icon: Icon(Icons.arrow_circle_right_outlined))
             ],
           ),
          ],
        ):const Center(child: Text('No Complain Details'),)
    )  ;
  }


}