
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../models/Vaccination.dart';
import '../../../resources/firebase_database_methods.dart';
import '../../vaccination_screens/vaccination_card_widget.dart';
import '../drawer_widger.dart';

class CalledVaccinationsListScreen extends StatefulWidget {
  const CalledVaccinationsListScreen({Key? key}) : super(key: key);

  @override
  State<CalledVaccinationsListScreen> createState() =>
      _CalledVaccinationsListScreenState();
}

class _CalledVaccinationsListScreenState extends State<CalledVaccinationsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Called CVaccinations'),
      ),
      drawer: DrawerWidget(),
      body: isDoctorBinded
          ? FirebaseDatabaseListView(
              // loadingBuilder: (context){
              //   return Text('Loading');
              // },
              // key: PageStorageKey<String>('petList'),

              query: FirebaseDatabaseMethods().reference(
                path: 'vaccinations/called',
              ),

              itemBuilder: (context, snapshot) {
                Vaccination vaccination = Vaccination.fromJson((snapshot.value));
                return VaccinationCardWidget(vaccination: vaccination ,);
              },
            )
          : const Center(
              child: Text('Please meet your doctor to setup'),
            ),
    );
  }
}
