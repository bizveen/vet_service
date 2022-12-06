
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../models/Contact.dart';
import '../../resources/firebase_database_methods.dart';
import '../view_details_screens/view_client_details_screen/view_client_details_screen.dart';

class ContactSearchScreen extends StatefulWidget {
  const ContactSearchScreen({Key? key}) : super(key: key);

  @override
  State<ContactSearchScreen> createState() => _ContactSearchScreenState();
}

class _ContactSearchScreenState extends State<ContactSearchScreen> {
  TextEditingController numberSearchController = TextEditingController();
  late String numberSearch;
  @override
  void initState() {
    numberSearch = numberSearchController.text;
    super.initState();
  }
  @override
  void dispose() {
    numberSearchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(child: const Text('Search by Contact Number'), onPressed: () {
            setState((){
              numberSearch = numberSearchController.text;
            });

          },),
          TextFormField(
            controller: numberSearchController,
            onChanged: (value){
              setState(() {
                numberSearch = value;
              });
            },
          ),
          Expanded(
            child: FirebaseDatabaseListView(
                query: FirebaseDatabaseMethods().reference(path: '$doctorPath/contacts').orderByChild('contactNo').startAt(numberSearch).endAt('$numberSearch\uf8ff'),
                shrinkWrap: true,
                itemBuilder: (context, snapshot){
                  Contact contact = Contact.fromJson(snapshot.value);
                  return ListTile(
                    title: Text(contact.contactNumber.toString()),
                    subtitle: Text(contact.clientName.toString()),
                    trailing:  IconButton(icon: const Icon(Icons.arrow_circle_right), onPressed: () {
                      Get.to(ViewClientDetailsScreen(clientId: contact.clientId!));
                    },


                    ),
                  );
                }),
          )
        ],
       
      ),
    );
  }
}
