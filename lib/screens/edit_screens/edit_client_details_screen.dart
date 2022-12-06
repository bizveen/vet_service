
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';

import '../../constants.dart';
import '../../models/client_model.dart';
import '../../resources/database_object_paths/other_paths.dart';
import '../../resources/firebase_database_methods.dart';
import '../../utils/utils.dart';
import '../../widgets/edit_widgets/edit_using_dropdown_list_widget.dart';
import '../../widgets/edit_widgets/edit_using_text_field_widget.dart';
import '../../widgets/pet_card2.dart';

class EditClientDetailsScreen extends StatefulWidget {
  String clientId;
   EditClientDetailsScreen({Key? key, required this.clientId}) : super(key: key);

  @override
  State<EditClientDetailsScreen> createState() => _EditClientDetailsScreenState();
}

class _EditClientDetailsScreenState extends State<EditClientDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return FirebaseDatabaseQueryBuilder(
      pageSize: 50,
      query: FirebaseDatabaseMethods().reference(path: 'clients/real/${widget.clientId}'),
      builder: (context, snapshot, _) {
        ClientModel client = ClientModel.fromJson(dataSnapShotListToMap(children: snapshot.docs));
        return Scaffold(
          appBar: AppBar(
            title: Text('Edit Client Details'),
          ),
          body: Column(
            children: [
              EditUsingTextFieldWidget(
                id: client.id!,
                  variable: 'name',
                  pathList: clientPaths(clientStatus: ClientStatus.real),
                  child: Text(client.name!)),
              EditUsingTextFieldWidget(
                  id: client.id!,
                  variable: 'address',
                  pathList: clientPaths(clientStatus: ClientStatus.real),
                  child: Text(client.address!)),
              EditUsingDropdownListWidget(
                databaseListPath: '$doctorPath/areas',
                  databaseListVariable: 'name',
                  hintText: 'Select Area',
                  id: client.id!,
                  variable: 'area',
                  pathList: clientPaths(clientStatus: ClientStatus.real),
                  child: Text(client.area!)),

              Wrap(children: client.contacts!.map((e) =>
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: EditUsingTextFieldWidget(
                      id: e!.id!,
                      pathList: contactPaths(clientId: client.id!),
                      variable: 'contactNo',
                      child: Chip(label: Text(e.contactNumber!),
                      ),
                    ),
                  ),
              ).toList()),
              client.pets != null
                  ? Wrap(
                children: client.pets!
                    .map((e) => PetCard2(
                  pet: e!,
                  client: client,
                ))
                    .toList(),
              )

              //return PetCard2(pet: client.pets![index]!);})
                  : const Center(
                child: Text('No Pets'),
              ),
            ],
          ),
        );
      }
    );
  }
}
