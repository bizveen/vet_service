
  import 'package:flutter/material.dart';
  import 'package:flutterfire_ui/database.dart';
  import 'package:get/get.dart';
  import 'package:getwidget/components/search_bar/gf_search_bar.dart';
  import 'package:string_extensions/string_extensions.dart';
  import 'package:uuid/uuid.dart';

import '../../../../constants.dart';
import '../../../../models/Vaccine.dart';
import '../../../../resources/firebase_database_methods.dart';



  class SearchVaccineWidget extends StatefulWidget {
    String title;
    Function (Vaccines) onSelect;
     SearchVaccineWidget({Key? key , required this.title , required this.onSelect}) : super(key: key);

    @override
    State<SearchVaccineWidget> createState() => _SearchVaccineWidgetState();
  }

  class _SearchVaccineWidgetState extends State<SearchVaccineWidget> {
    TextEditingController searchController = TextEditingController();
    List<Vaccines> listItems = [];
    Vaccines? selectedValue;
    bool isUploading = false;
    String databasePath = '$doctorPath/vaccines';
    @override
    void dispose() {

      super.dispose();
      searchController.dispose();
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
              listItems.clear();
              for (final child in snapshot.docs) {
                listItems.add(Vaccines.fromJson(child.value as Map<dynamic,dynamic>));
              }
            }
            return GFSearchBar<Vaccines?>(



              controller: searchController,
              searchList: listItems,
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
                    item!.name.toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              },
              onItemSelected: (item) {
                setState(() {
                  selectedValue = item;
                });

                widget.onSelect(item!);
              },
            );
          });
    }

    List<Vaccines?> filterMethod(searchText) {
      List<Vaccines?> filteredList = [];
      List<Vaccines?> tempList = listItems;
      List<String> subWords = searchText.split(' ');
      for (int i = 0; i < subWords.length; i++) {
        tempList = tempList
            .where((element) => element!.name
            .toString()
            .toLowerCase()
            .contains(subWords[i].toLowerCase()))
            .toList();
        filteredList = tempList;
      }
      return filteredList.toSet().toList();
    }
  }
