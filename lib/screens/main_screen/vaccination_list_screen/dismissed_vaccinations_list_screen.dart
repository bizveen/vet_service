
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../models/Vaccination.dart';
import '../../../resources/firebase_database_methods.dart';
import '../../vaccination_screens/vaccination_card_widget.dart';
import '../drawer_widger.dart';

class DismissedVaccinationsListScreen extends StatefulWidget {
  const DismissedVaccinationsListScreen({Key? key}) : super(key: key);

  @override
  State<DismissedVaccinationsListScreen> createState() =>
      _DismissedVaccinationsListScreenState();
}

class _DismissedVaccinationsListScreenState
    extends State<DismissedVaccinationsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dismissed Complains'), actions: []),
      drawer: DrawerWidget(),
      body: isDoctorBinded
          ? FirebaseDatabaseListView(
              // loadingBuilder: (context){
              //   return Text('Loading');
              // },
              // key: PageStorageKey<String>('petList'),

              query: FirebaseDatabaseMethods().reference(
                path: 'vaccinations/dismissed',
              ),

              itemBuilder: (context, snapshot) {
                Vaccination vaccination = Vaccination.fromJson((snapshot.value));
                return VaccinationCardWidget(vaccination: vaccination , );
              },
            )
          : const Center(
              child: Text('Please meet your doctor to setup'),
            ),
    );
  }
}
