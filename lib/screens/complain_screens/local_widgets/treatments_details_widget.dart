
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';

import '../../../models/complain/Complain.dart';
import '../../../resources/database_object_paths/complain_paths.dart';

import '../../../resources/firebase_database_methods.dart';
import '../../../widgets/container_with_border.dart';
import '../../add_treatment_screen/add_treatment_screen.dart';
import 'decoration_widget.dart';
import 'treatment_tile_widget.dart';

class TreatmentDetailsWidget extends StatelessWidget {
  const TreatmentDetailsWidget({
    Key? key,
    required this.complain,
  }) : super(key: key);

  final Complain complain;

  @override
  Widget build(BuildContext context) {
    List<Widget>? treatmentList;
    if (complain.treatmentList != null) {
      treatmentList = List.generate(
        complain.treatmentList!.length,
        (index) => Slidable(
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
                onPressed: (BuildContext context) {
                  FirebaseDatabaseMethods().updateBatch(updateComplainSubJson(
                      petId: complain.petId!,
                      clientId: complain.clientID!,
                      json: [{}],
                      id: complain.treatmentList![index]!.id!,
                      complainId: complain.id!,
                      complainSub: ComplainSub.treatments,
                      complainStatus: ComplainStatus.active));
                },
              ),
            ],
          ),
          child:
              TreatmentTileWidget(treatment: complain.treatmentList![index]!),
        ),
      );


    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecorationWidget(
          title: 'Treatments',
          onAddPressed: () {
            Get.to(() => AddTreatmentScreen(complain: complain));
          },
          children: treatmentList,
        ),
      ],
    );
  }
}
