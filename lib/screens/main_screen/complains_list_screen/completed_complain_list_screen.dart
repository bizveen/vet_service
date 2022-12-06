
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../models/complain/Complain.dart';
import '../../../resources/database_object_paths/complain_paths.dart';
import '../../../resources/firebase_database_methods.dart';
import '../../complain_screens/complain_details_screen.dart';
import '../drawer_widger.dart';

class CompletedComplainListScreen extends StatefulWidget {
  const CompletedComplainListScreen({Key? key}) : super(key: key);

  @override
  State<CompletedComplainListScreen> createState() =>
      _CompletedComplainListScreenState();
}

class _CompletedComplainListScreenState
    extends State<CompletedComplainListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Completed Complains'), actions: []),
      drawer: DrawerWidget(),
      body: isDoctorBinded
          ? FirebaseDatabaseListView(
              // loadingBuilder: (context){
              //   return Text('Loading');
              // },
              // key: PageStorageKey<String>('petList'),

              query: FirebaseDatabaseMethods().reference(
                path: 'complains/completed',
              ),

              itemBuilder: (context, snapshot) {
                Complain complain = Complain.fromJson((snapshot.value));
                // log(complain.toJson().toString() , name: 'Completed Complain');
                return ListTile(
                  onTap: () async {
                    Get.to(ComplainDetailsScreen(
                        complain: complain,
                        client: await FirebaseDatabaseMethods()
                            .getClientFromID(id :complain.clientID!),complainStatus: ComplainStatus.completed,));
                  },
                  title: Text(complain.getTitle()),
                );
              },
            )
          : const Center(
              child: Text('Please meet your doctor to setup'),
            ),
    );
  }
}
