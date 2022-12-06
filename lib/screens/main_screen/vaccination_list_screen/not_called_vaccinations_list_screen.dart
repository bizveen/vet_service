
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../models/Vaccination.dart';
import '../../../resources/firebase_database_methods.dart';
import '../../vaccination_screens/vaccination_card_widget.dart';
import '../../vaccination_screens/view_vaccination_details_screen.dart';
import '../drawer_widger.dart';

class NotCalledVaccinationsListScreen extends StatefulWidget {
  const NotCalledVaccinationsListScreen({Key? key}) : super(key: key);

  @override
  State<NotCalledVaccinationsListScreen> createState() =>
      _NotCalledVaccinationsListScreenState();
}

class _NotCalledVaccinationsListScreenState
    extends State<NotCalledVaccinationsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Not Called Vaccinations'), actions: []),
      drawer: DrawerWidget(),
      body: isDoctorBinded
          ? FirebaseDatabaseListView(
              // loadingBuilder: (context){
              //   return Text('Loading');
              // },
              // key: PageStorageKey<String>('petList'),

              query: FirebaseDatabaseMethods().reference(
                path: 'vaccinations/notCalled',
              ),

              itemBuilder: (context, snapshot) {
                Vaccination vaccination = Vaccination.fromJson((snapshot.value));
                // log(complain.toJson().toString() , name: 'Completed Complain');
                return VaccinationCardWidget(vaccination: vaccination,);
              },
            )
          : const Center(
              child: Text('Please meet your doctor to setup'),
            ),
    );
  }
}
