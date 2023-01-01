import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_service/resources/firebase_database_methods.dart';
import 'package:vet_service/utils/utils.dart';

import '../../models/Contact.dart';

class ContactSearchScreen extends StatefulWidget {
  @override
  _ContactSearchScreenState createState() => _ContactSearchScreenState();
}

class _ContactSearchScreenState extends State<ContactSearchScreen> {
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Contacts'),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (query) {
              setState(() {
                _searchQuery = query;
              });
            },
          ),
          Expanded(
            child: FutureBuilder(
              future: FirebaseDatabaseMethods().getSearchResults2(getCombinations(_searchQuery.split(' '))),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  List<Contact> contacts = snapshot.data as List<Contact>;
                  return ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      Contact contact = contacts[index];
                      return ListTile(
                        title: Text(contact.clientName ?? "No Name"),
                        subtitle: Text(contact.contactNumber ?? "No Number"),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

}