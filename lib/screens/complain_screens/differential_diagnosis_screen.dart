
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';
import '../../models/Pet.dart';
import '../../models/complain/Complain.dart';
import '../../resources/database_object_paths/complain_paths.dart';
import '../../resources/firebase_database_methods.dart';
import '../../utils/utils.dart';

import '../chart_screens/weight_chart_screen.dart';
import 'local_widgets/differential_diagnosis_details_widget.dart';
import 'local_widgets/treatments_details_widget.dart';

class DifferentialDiagnosisScreen extends StatefulWidget {
  Complain complain;


  DifferentialDiagnosisScreen({
    Key? key,
    required this.complain,
  }) : super(key: key);

  @override
  State<DifferentialDiagnosisScreen> createState() =>
      _DifferentialDiagnosisScreenState();
}

class _DifferentialDiagnosisScreenState
    extends State<DifferentialDiagnosisScreen> {
  TextEditingController dDCommentController = TextEditingController();

  @override
  void dispose() {

    super.dispose();
    dDCommentController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FirebaseDatabaseQueryBuilder(
      pageSize: 50,
      query: FirebaseDatabaseMethods().reference(
        path: 'complains/all/${widget.complain.id}',
      ),
      builder: (context, snapshot, _) {
        Complain complain = Complain.fromJson(
          dataSnapShotListToMap(children: snapshot.docs),
        );
        return Scaffold(
          appBar: AppBar(
            title: const Text('Differential Diagnosis Screen'),
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
                          (complain.startedDateTime ?? '0').toString())))
                          .toString()),
                      Text(
                        'Pet Details',
                        style: Get.textTheme.headline6,
                      ),
                      FutureBuilder(
                          future: FirebaseDatabaseMethods()
                              .getPetFromID(id: widget.complain.petId!),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.connectionState == ConnectionState.done) {
                              Pet pet = snapshot.data as Pet;
                              return Column(
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
                              );
                            }
                            return Center(
                              child: Text('Error'),
                            );
                          }),
                    ],
                  ),
                  // ClientCardWidget(
                  //     clientModel: widget.client,
                  //     selectedPetId: widget.complain.petId),

                  widget.complain.getFirstInspectionSummery(),

                  DiffrentialDiagnosisDetailsWidget(
                    complainStatus: ComplainStatus.values[complain.status!],
                    complain: complain,
                  ),
                  TreatmentDetailsWidget(
                    complain: complain,
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
