
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';
import 'package:vet_service/controllers/client_controller.dart';
import 'package:vet_service/models/client_model.dart';
import 'package:vet_service/resources/firebase_firestore_methods.dart';
import '../../models/Pet.dart';
import '../../models/complain/Complain.dart';
import '../../resources/database_object_paths/complain_paths.dart';
import '../../resources/firebase_database_methods.dart';
import '../../utils/utils.dart';

import '../chart_screens/weight_chart_screen.dart';
import 'local_widgets/differential_diagnosis_details_widget.dart';
import 'local_widgets/treatments_details_widget.dart';

class DoctorWorkBenchScreen extends GetWidget<ClientController> {
  Complain complain;


  DoctorWorkBenchScreen({
    Key? key,
    required this.complain,
  }) : super(key: key);


  TextEditingController dDCommentController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ClientModel>(

      stream: controller.getClientFromId (complain.clientID!),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());}
        ClientModel? client = snapshot.data;
        Pet pet = client!.pets!.where((element) => element!.id == complain.petId).first!;
        Complain cmpl = pet.complains!.where((element) => element!.id == complain.id).first!;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Doctor's Work Bench"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(

                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Presented Date',
                        style: Get.textTheme.headline6,
                      ),
                      Text(dateWithTimeFormatter
                          .format(DateTime.fromMicrosecondsSinceEpoch(int.parse(
                          (cmpl.startedDateTime ?? '0').toString())))
                          .toString()),
                      Text(
                        'Pet Details',
                        style: Get.textTheme.headline6,
                      ),
                     Column(
                                children: [
                                  Table(

                                    children: [
                                      TableRow(children: [
                                        const Text('Name'),
                                        Text(pet.name ?? 'No Name'),
                                      ]),
                                      TableRow(children: [
                                        const Text('Gender'),
                                        Text(pet.gender ?? 'Not sure'),
                                      ]),
                                      TableRow(children: [
                                        const Text('Breed'),
                                        Text(pet.breed ?? 'Not sure'),
                                      ]),
                                      TableRow(children: [
                                        const Text('Birth Day'),
                                        Text(dateFormatter.format( DateTime.fromMicrosecondsSinceEpoch(pet.birthDay!)).toString()),
                                      ])
                                    ],
                                  ),
                                  IconButton(onPressed: (){
                                    Get.defaultDialog(
                                      content:  SizedBox(
                                        width: 500,
                                        height: 200,
                                        child: Card(
                                            child: WeightChartScreen( weightList: pet.weight!,)),
                                      ),
                                      onConfirm: (){
                                        Get.back();
                                      }
                                    );

                                  }, icon: Icon(Icons.ssid_chart)),

                                  pet.getComplainSummery(),
                                ],
                     )


                    ],
                  ),
                  // ClientCardWidget(
                  //     clientModel: widget.client,
                  //     selectedPetId: widget.complain.petId),

                  complain.getFirstInspectionSummery(),

                  DiffrentialDiagnosisDetailsWidget(
                    complainStatus: ComplainStatus.values[cmpl.status??0],
                    complain: cmpl,
                  ),
                  TreatmentDetailsWidget(
                    complain: cmpl,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
