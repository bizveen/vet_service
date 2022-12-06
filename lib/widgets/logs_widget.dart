


import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../models/client_model.dart';
import '../models/complain/Complain.dart';
import '../models/log.dart';
import '../resources/firebase_database_methods.dart';
import '../utils/utils.dart';

class LogsWidget extends StatelessWidget {
  String? clientId;
  String? complainId;
  String? vaccinationId;
  String ?saleId;
  bool isACall;
   LogsWidget({
    Key? key,
    this.complainId,
    this.clientId,
    this.vaccinationId,
    this.saleId,
     this.isACall = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(

      child: FirebaseDatabaseListView(
          shrinkWrap: true,
          query:
          complainId != null ?
          FirebaseDatabaseMethods().reference(path: '$doctorPath/logs').orderByChild('complainId').equalTo(complainId)
          : vaccinationId != null ?
          FirebaseDatabaseMethods().reference(path: '$doctorPath/logs').orderByChild('vaccinationId').equalTo(vaccinationId)
          : clientId != null ?
          FirebaseDatabaseMethods().reference(path: '$doctorPath/logs').orderByChild('clientId').equalTo(clientId)
          : FirebaseDatabaseMethods().reference(path: '$doctorPath/logs')
          ,
          itemBuilder: (context, snapshot){
            Log log = Log.fromJson(map : (snapshot.value as Map<dynamic, dynamic>));
            return isACall ? ListTile(
              title: log.getTitle(),
              subtitle: log.complainId != null ? TextButton(
                onPressed: ()async{
                  }, child: Text('Complain'),)

                  : log.vaccinationId != null ? Text('Vaccination')
              : Container() ,
            ) : ListTile(
              title: log.getTitle(),
              subtitle: log.complainId != null ? FirebaseDatabaseQueryBuilder(
                  query: FirebaseDatabaseMethods().reference(path: log.complainPath!),

                  builder: (context , snapshot , _) {

                    Complain complain = Complain.fromJson(dataSnapShotListToMap(children: snapshot.docs));

                    return TextButton(onPressed: ()async{
                      ClientModel client =await  FirebaseDatabaseMethods().getClientFromID(id :log.clientId!, clientStatus: ClientStatus.real);
                     // Get.to(ComplainDetailsScreen(complain: complain, client: client ));
                    }, child: Text('${complain.petName} : Complain'),);
                  }
              )
                  : log.vaccinationId != null ? Text('Vaccination')
                  : Container() ,
            );
          }),
    );
  }
}
