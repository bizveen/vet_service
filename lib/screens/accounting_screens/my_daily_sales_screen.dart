
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:string_extensions/string_extensions.dart';

import 'package:collection/collection.dart';

import '../../models/sale/Invoice.dart';
import '../../resources/firebase_database_methods.dart';
import '../../utils/utils.dart';

class MyDailySalesScreen extends StatelessWidget {
  const MyDailySalesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Daily Sales Screen')),
      body: FirebaseDatabaseListView(
        query: FirebaseDatabaseMethods().reference(path: 'users/${FirebaseAuth.instance.currentUser!.uid}/ownSales/dayByDay'),
        itemBuilder: (context, snapshot){
          List<Invoice> dailySalesList = [];
          snapshot.children.forEach((element) { dailySalesList.add(Invoice.fromJson(element.value));});
          double dailyTotal = dailySalesList.fold(0, (previousValue, element) => double.parse(previousValue!.toString()) + element.getTotalCharges()!);
          return ExpansionTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(dateFormatter.format(DateTime.fromMicrosecondsSinceEpoch(snapshot.key!.toInt()!)).toString()),
                Text(dailyTotal.toString())
              ],
            ),
            children: dailySalesList.map((e) => ListTile(title: Text(e.getTotalCharges().toString()),)).toList(),);
        },
      ),
    );
  }
}
