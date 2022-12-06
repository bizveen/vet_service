import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/complain/Treatment.dart';
import '../../../resources/database_object_paths/complain_paths.dart';
import '../../../resources/firebase_database_methods.dart';

class TreatmentTileWidget extends StatefulWidget {
  Treatment treatment;
   TreatmentTileWidget({Key? key, required this.treatment}) : super(key: key);

  @override
  State<TreatmentTileWidget> createState() => _TreatmentTileWidgetState();
}

class _TreatmentTileWidgetState extends State<TreatmentTileWidget> {
  @override
  Widget build(BuildContext context) {
    return  ListTile(
      onLongPress: (){
        Get.defaultDialog(
            content: Text('Do you want to delete?'),
            onConfirm: ()async {
              await FirebaseDatabaseMethods().updateBatch(
                  updateComplainSubJson(
                      petId: widget.treatment.petId!,
                      clientId: widget.treatment.clientId!,
                      json: [{}],
                      id: widget.treatment.id!,
                      complainId: widget.treatment.complainId!,
                      complainSub: ComplainSub.treatments,
                      complainStatus: ComplainStatus.active
                  ));
              Get.back();
            }
        );
      },
      title: Text(widget.treatment.getTreatmentTitle()!),
      subtitle: Text(
          widget.treatment.charges.toString()),
    );
  }
}
