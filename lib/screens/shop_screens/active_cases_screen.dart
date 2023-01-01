import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';

import 'package:vet_service/screens/shop_screens/invoice_tile.dart';
import '../../constants.dart';

import '../../models/sale/Invoice.dart';

import '../../resources/firebase_database_methods.dart';


class ActiveCasesScreen extends StatefulWidget {
  const ActiveCasesScreen({Key? key}) : super(key: key);

  @override
  State<ActiveCasesScreen> createState() => _ActiveCasesScreenState();
}

class _ActiveCasesScreenState extends State<ActiveCasesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Active Cases Screen"),),
      body:   FirebaseDatabaseListView(
          query: FirebaseDatabaseMethods()
              .reference(path: '$doctorPath/invoices/all')
              .orderByChild('isActive')
              .equalTo(true),
          itemBuilder: (context, snapshot) {

              Invoice sale = Invoice.fromJson(snapshot.value);

            return InvoiceTile(sale: sale);
          }),
    );
  }
}
