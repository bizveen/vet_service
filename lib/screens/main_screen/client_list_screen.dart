
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutterfire_ui/database.dart';
import '../../constants.dart';
import '../../models/client_model.dart';
import '../../resources/firebase_database_methods.dart';

import '../../widgets/client_card.dart';
import 'drawer_widger.dart';

class ClientListScreen extends StatefulWidget {
  const ClientListScreen({Key? key}) : super(key: key);

  @override
  State<ClientListScreen> createState() => _ClientListScreenState();
}

class _ClientListScreenState extends State<ClientListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Client Manager'), actions: [
          IconButton(
              onPressed: () {
                // Get.to(Main2());
              },
              icon: const Icon(Icons.title)),
          IconButton(
              onPressed: () {
                // Get.to(SearchScreen());
              },
              icon: const Icon(Icons.search)),
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () {
              // Get.to(CallKitIncomming());
            },
            icon: const Icon(Icons.call),
          ),
        ]),
        drawer: const DrawerWidget(),
        body:FirebaseDatabaseListView(
                key: const PageStorageKey<String>('clientList'),
                query: FirebaseDatabaseMethods()
                    .reference(path: '$doctorPath/clients/real'),
                itemBuilder: (context, snapshot) {
                  ClientModel client = ClientModel.fromJson((snapshot.value));
                  return ClientCard(
                    client: client,
                  );
                },
              ),

    );
  }
}
