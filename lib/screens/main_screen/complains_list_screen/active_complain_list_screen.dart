
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../models/complain/Complain.dart';
import '../../../resources/database_object_paths/complain_paths.dart';
import '../../../resources/firebase_database_methods.dart';
import '../../complain_screens/complain_details_screen.dart';
import '../../complain_screens/local_widgets/complain_followup_card.dart';
import '../drawer_widger.dart';

class ActiveComplainListScreen extends StatefulWidget {
  const ActiveComplainListScreen({Key? key}) : super(key: key);

  @override
  State<ActiveComplainListScreen> createState() =>
      _ActiveComplainListScreenState();
}

class _ActiveComplainListScreenState extends State<ActiveComplainListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Complains'),
      ),
      drawer: DrawerWidget(),
      body: isDoctorBinded
          ? FirebaseDatabaseListView(
              // loadingBuilder: (context){
              //   return Text('Loading');
              // },
              // key: PageStorageKey<String>('petList'),

              query: FirebaseDatabaseMethods().reference(
                path: 'complains/active',
              ),

              itemBuilder: (context, snapshot) {
                Complain complain = Complain.fromJson((snapshot.value));
                return InkWell(
                  onTap: ()async{
                    Get.to(ComplainDetailsScreen(
                        complainId: complain.id!,
                        clientId:complain.clientID!,
                      petId: complain.petId!,
                      complainStatus: ComplainStatus.all,));
                  },
                  child: ComplainFollowupCard(complainStatus: ComplainStatus.active, complain: complain, )
                );
              },
            )
          : const Center(
              child: Text('Please meet your doctor to setup'),
            ),
    );
  }
}
