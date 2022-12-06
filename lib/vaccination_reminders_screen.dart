
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'constants.dart';
import 'models/Vaccination.dart';
import 'resources/firebase_database_methods.dart';

class VaccinationRemindersScreen extends StatefulWidget {
  const VaccinationRemindersScreen({Key? key}) : super(key: key);

  @override
  State<VaccinationRemindersScreen> createState() => _VaccinationRemindersScreenState();
}

class _VaccinationRemindersScreenState extends State<VaccinationRemindersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vaccination Reminders'),
        
      ),
      body: FirebaseDatabaseListView(
        query: FirebaseDatabaseMethods().reference(path: '$doctorPath/vaccinationReminders'),
        itemBuilder: (context , snapshot){
          Vaccination vaccination = Vaccination.fromJson(snapshot.value as Map<dynamic, dynamic>);

          return ListTile(
            title: Text(vaccination.givenVaccine!.name!),
            subtitle: Text(vaccination.givenDate.toString()),
          );
        },
      ),
    );
  }
}
