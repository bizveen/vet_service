
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';
import 'package:vet_service/models/Contact.dart';

import '../../constants.dart';
import '../../models/client_model.dart';
import '../../resources/firebase_database_methods.dart';
import '../../widgets/client_card.dart';

class ClientSearchScreen extends StatefulWidget {
  const ClientSearchScreen({Key? key}) : super(key: key);

  @override
  State<ClientSearchScreen> createState() => _ClientSearchScreenState();
}

class _ClientSearchScreenState extends State<ClientSearchScreen> {
  TextEditingController clientSearchController = TextEditingController();
  late String search;
  bool contactNoSearch = true;
  bool clientNameSearch = false;
  bool petNameSearch = false;
  String contactPath = '$doctorPath/contactNumbersList';
  String clientNamePath = '$doctorPath/clients/real';
  String petNamePath = '$doctorPath/pets';

  @override
  void initState() {
    search = clientSearchController.text;
    super.initState();
  }
  @override
  void dispose() {
    clientSearchController.dispose();
    super.dispose();
  }
  // @override
  // void setState(VoidCallback fn) {
  //   clientSearchController.value = TextEditingValue(text: search);
  //   super.setState(fn);
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          TextFormField(
            decoration: const InputDecoration(hintText: "Search by Name"),
            controller: clientSearchController,
            onChanged: (value){
              if(value.isNum){
                setState(() {
                  contactNoSearch=true;
                  clientNameSearch = false;
                  petNameSearch = false;
                });
              }else if(value.contains('.')){
                setState(() {
                  contactNoSearch=false;
                  clientNameSearch = true;
                  petNameSearch = false;
                });
              }else{
              setState(() {
                contactNoSearch=false;
                clientNameSearch = false;
                petNameSearch = true;
              });}
            },
          ),
          Expanded(
            child:
            contactNoSearch ?
            FirebaseDatabaseListView(
                query: FirebaseDatabaseMethods().reference(path: contactPath).orderByChild('contactNumber').startAt("[a-zA-Z0-9]*").endAt(search),
                shrinkWrap: true,
                itemBuilder: (context, snapshot){
                  Contact contact = Contact.fromJson(snapshot.value );
                  return ListTile(title: Text(contact.contactNumber ?? "No Number"), subtitle: Text(contact.clientName!),);
                }) :
            clientNameSearch ?  FirebaseDatabaseListView(
                query: FirebaseDatabaseMethods().reference(path: clientNamePath).orderByChild('clientName').startAt(search.toLowerCase()).endAt('${search.toLowerCase()}\uf8ff'),
                shrinkWrap: true,
                itemBuilder: (context, snapshot){
                  ClientModel client = ClientModel.fromJson(snapshot.value);
                  return ClientCard(client: client);
                }) :
            FirebaseDatabaseListView(
                query: FirebaseDatabaseMethods().reference(path: petNamePath).orderByChild('name').startAt(search.toLowerCase()).endAt('${search.toLowerCase()}\uf8ff'),
                shrinkWrap: true,
                itemBuilder: (context, snapshot){
                  ClientModel client = ClientModel.fromJson(snapshot.value);
                  return ClientCard(client: client);
                }) ,
          )
        ],
       
      ),
    );
  }
}
