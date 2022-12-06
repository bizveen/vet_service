
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/search_bar/gf_search_bar.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:vet_service/constants.dart';

import '../../../controllers/global_live_variables_controller.dart';
import '../../../resources/firebase_database_methods.dart';
import '../models/client_model.dart';

class SearchClientWidget extends StatefulWidget {
  String title;
  TextEditingController searchController;
  Function (ClientModel) onSelect;
  SearchClientWidget({Key? key , required this.title , required this.onSelect, required this.searchController}) : super(key: key);

  @override
  State<SearchClientWidget> createState() => _SearchClientWidgetState();
}

class _SearchClientWidgetState extends State<SearchClientWidget> {
 // TextEditingController searchController = TextEditingController();
  List<ClientModel> clientsList = [];
  ClientModel? selectedValue;
  bool isUploading = false;
  String databasePath = '$doctorPath/clients/real';
  @override
  void dispose() {

    super.dispose();
    //widget.searchController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FirebaseDatabaseQueryBuilder(
        query: FirebaseDatabaseMethods().reference(path: databasePath),
        builder: (context, snapshot, _) {
          if (snapshot.isFetching) {
            return SizedBox(
                width: Get.width * 0.5,
                child: const LinearProgressIndicator());
          } else if (snapshot.hasData) {
            clientsList.clear();
            for (final child in snapshot.docs) {
              clientsList.add(ClientModel.fromJson(child.value as Map<dynamic,dynamic>));
            }
          }
          return GFSearchBar<ClientModel>(



            controller: widget.searchController,
            searchList: clientsList,

            searchBoxInputDecoration: InputDecoration(

              hintText:
              (selectedValue!= null ? selectedValue!.name :  widget.title).toTitleCase,
              hintStyle: const TextStyle(color: Colors.black),
              suffixIcon: const Icon(Icons.search),
            ),
            noItemsFoundWidget: Container(

                height: 50,
                child: Center(child: Text('No Item'))),
            searchQueryBuilder: (query, list) {
              return filterMethod(query);
            },
            overlaySearchListItemBuilder: (item) {

              return Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  item.name.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
              );
            },
            onItemSelected: (item) {
              setState(() {
                selectedValue = item;
              });

              widget.onSelect(item);
            },

          );
        });
  }

  List<ClientModel> filterMethod(searchText) {
    List<ClientModel> filteredList = [];
    List<ClientModel> tempList = clientsList;
    List<String> subWords = searchText.split(' ');
    for (int i = 0; i < subWords.length; i++) {
      tempList = tempList
          .where((element) => element.name
          .toString()
          .toLowerCase()
          .contains(subWords[i].toLowerCase()))
          .toList();
      filteredList = tempList;
    }
    return filteredList.toSet().toList();
  }
}
