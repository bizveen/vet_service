import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';

import '../../models/Vaccination.dart';
import '../../models/client_model.dart';
import '../../resources/database_object_paths/log_paths.dart';
import '../../resources/database_object_paths/vaccination_paths.dart';
import '../../resources/firebase_database_methods.dart';
import '../../utils/utils.dart';
import '../../widgets/header_text.dart';
import '../calling_screen/calling_screen.dart';
import '../view_details_screens/view_client_details_screen/view_client_details_screen.dart';

class ViewVaccinationDetailsScreen extends StatefulWidget {
  String vaccinationId;

  ViewVaccinationDetailsScreen({
    Key? key,
    required this.vaccinationId,
  }) : super(key: key);

  @override
  State<ViewVaccinationDetailsScreen> createState() =>
      _ViewVaccinationDetailsScreenState();
}

class _ViewVaccinationDetailsScreenState
    extends State<ViewVaccinationDetailsScreen> {
  Future<void> swapVaccination(
      {required VaccinationStatus to, required Vaccination vaccination}) async {
    await FirebaseDatabaseMethods().updateBatch(swapVaccinationJson(
        vaccination: vaccination.copyWith(vaccinationStatus: to.index),
        from: VaccinationStatus.values[vaccination.vaccinationStatus!],
        to: to));

   // Get.to(ViewVaccinationDetailsScreen(vaccinationId: vaccination.id!));
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
        future: FirebaseDatabaseMethods().getClientFromID(id: widget.vaccinationId),
        builder: (context , snapshot) {
          if(snapshot.connectionState  != ConnectionState.done){
            return const Card(child: CircularProgressIndicator(),);
          }
ClientModel client = snapshot.data as ClientModel;
          return FirebaseDatabaseQueryBuilder(
            pageSize: 50,
            query: FirebaseDatabaseMethods()
                .reference(path: 'vaccinations/all/${widget.vaccinationId}'),
            builder: (context, snapshot, _) {
              if (snapshot.isFetching) {

                    return Scaffold(
                      appBar: AppBar(

                      ),
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );

              }
              Vaccination vaccination = Vaccination.fromJson(
                dataSnapShotListToMap(children: snapshot.docs),
              );
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Vaccination Details'),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Get.to(CallingScreen(
                            contactList: client.contacts!,
                            logType: LogType.vaccination,
                            clientId: client.id!,
                            petId: vaccination.petId,
                            vaccinationId: vaccination.id,
                            logList: vaccination.logList,
                          ));
                        },
                        icon: Icon(Icons.call))
                  ],
                ),
                body: Column(

                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Given Vaccine'),
                        )),
                    HeaderText(text : vaccination.givenVaccine!.name!),
                    (vaccination.images != null && vaccination.images!.isNotEmpty)
                        ? Image.network(vaccination.images![0]!.downloadUrl!)
                        : Container(),
                    Table(
defaultVerticalAlignment: TableCellVerticalAlignment.middle
                      ,
                      children: [
                        TableRow(

                          children: [
                            Text('Given On'),
                            Text(dateWithTimeFormatter.format(
                                DateTime.fromMicrosecondsSinceEpoch(vaccination.givenDate!))
                                .toString()),

                          ]
                        ),
                        TableRow(
                            children: [
                              Text('Next Vaccination'),
                              Text(vaccination.nextVaccination!),
                            ]
                        ),

                        TableRow(
                            children: [
                              Text('Next Date'),
                              Text(dateFormatter.format(
                                  DateTime.fromMicrosecondsSinceEpoch(vaccination.nextDate!))
                                  .toString()),
                            ]
                        ),
                        TableRow(
                            children: [
                              Text('Next ARV Date'),
                              Text(dateFormatter.format(
                                  DateTime.fromMicrosecondsSinceEpoch(vaccination.nextArvDate!))
                                  .toString()),
                            ]
                        ),

                        TableRow(
                            children: [
                              Text('View Client'),
                              TextButton(
                                onPressed: () {
                                  Get.to(ViewClientDetailsScreen(
                                      clientId: vaccination.clientId!,
                                    petId: vaccination.petId!,
                                  ));
                                },
                              child: Text('Go>', ),),
                            ]
                        )
                      ],
                    ),


                    Row(
                      children: [
                        vaccination.vaccinationStatus !=
                                VaccinationStatus.called.index
                            ? ElevatedButton(
                                onPressed: () async {
                                  await swapVaccination(
                                      vaccination: vaccination,
                                      to: VaccinationStatus.called);
                                },
                                child:
                                    Text('Called ${vaccination.vaccinationStatus}'))
                            : Container(),
                        ElevatedButton(
                            onPressed: () async {
                              await swapVaccination(
                                  vaccination: vaccination,
                                  to: VaccinationStatus.notCalled);
                            },
                            child: Text(
                                'Not Called ${vaccination.vaccinationStatus}')),
                        ElevatedButton(
                            onPressed: () async {
                              await swapVaccination(
                                  vaccination: vaccination,
                                  to: VaccinationStatus.dismissed);
                            },
                            child:
                                Text('Dismissed ${vaccination.vaccinationStatus}')),
                      ],
                    )
                  ],
                ),
              );
            });
      }
    );
  }
}
