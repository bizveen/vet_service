
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../constants.dart';
import '../models/Vaccination.dart';
import '../models/Vaccine.dart';
import '../models/client_model.dart';
import '../models/complain/Treatment.dart';
import '../models/sale/Invoice.dart';
import '../utils/utils.dart';
import 'database_object_paths/other_paths.dart';
import 'database_object_paths/sales_paths.dart';
import 'firebase_database_methods.dart';
import 'firebase_firestore_methods.dart';

class SalesMethods {
  ClientStatus clientStatus;
  Vaccination? vaccination;
  String? clientId;
  Treatment? treatment;


  SalesMethods({this.vaccination,  this.clientId, this.treatment, required this.clientStatus});



  _createVaccineSale({
    required String activeCaseId,
  }) async {
    await FirebaseDatabaseMethods().updateBatch(
      updateSalesSubJson(
        billingStatus: BillingStatus.notBill,
        clientStatus: clientStatus,
          clientId: clientId!,
          currentActiveCaseId: activeCaseId,
          salesSub: SalesSub.vaccines,
          json: [vaccination!.givenVaccine!.toJson()] , salesSubId: vaccination!.id),
    );
  }

  _createTreatmentSale({required String activeCaseId}) async {
    await FirebaseDatabaseMethods().updateBatch( updateSalesSubJson(
      billingStatus: BillingStatus.notBill,
      clientStatus: clientStatus,
        clientId: clientId!,
        currentActiveCaseId: activeCaseId,
        salesSub: SalesSub.treatments,
        json: [treatment!.toJson()] , salesSubId: treatment!.id),);
  }

  Future<void> createASale() async {
    if(clientId!= null){
    ClientModel client = await FirebaseFirestoreMethods().getClientFromFirestore( clientId:  clientId!);

    if (client.isActive == null || !client.isActive!) {
      final String currentId = const Uuid().v1();
      Invoice sale = Invoice(
        clientStatus: clientStatus.index,
        startedBy: FirebaseAuth.instance.currentUser!.email,
        isActive: true,
        clientId: client.id,
        dateTime: DateTime.now().microsecondsSinceEpoch,
        id: currentId,
        path: '$doctorPath/sales/$currentId',
      );

      // await FirebaseDatabaseMethods().updateBatch(updateSalesJson(
      //   clientStatus: clientStatus,
      //     clientId: client.id!, salesId: sale.id!, json: [sale.toJson()])
      //   ..addAll(updateClientJson(
      //       clientStatus: clientStatus,
      //       clientId: clientId!,
      //       json: [true, currentId],
      //       variables: ['isActive', 'currentActiveCaseId'])));
      if (vaccination != null) {
        await _createVaccineSale(activeCaseId: currentId);
      } else if (treatment != null) {
        await _createTreatmentSale(activeCaseId: currentId);
      }
    } else {
      if (vaccination != null) {
        await _createVaccineSale(activeCaseId: client.currentActiveCaseId!);
      } else if (treatment != null) {
        await _createTreatmentSale(activeCaseId: client.currentActiveCaseId!);
      }
    }
  } else{
      Invoice sale = Invoice(
        clientStatus: clientStatus.index,
        startedBy: FirebaseAuth.instance.currentUser!.email,
        isActive: true,
        dateTime: DateTime.now().microsecondsSinceEpoch,
        id: dateTimeDescender(dateTime: DateTime.now()).toString(),

      );
    }}
}
