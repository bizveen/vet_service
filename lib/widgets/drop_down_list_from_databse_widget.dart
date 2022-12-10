import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/search_bar/gf_search_bar.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:uuid/uuid.dart';

import '../resources/firebase_database_methods.dart';

class DropDownListFromDatabaseWidget extends StatefulWidget {
  DropDownListFromDatabaseWidget(
      {Key? key,
      required this.databasePath,
      required this.databaseVariable,
      required this.hintText,
      required this.onSelect})
      : super(key: key);
  String hintText;
  Function(String? selected) onSelect;

  String databasePath;
  String databaseVariable;

  @override
  State<DropDownListFromDatabaseWidget> createState() =>
      _DropDownListFromDatabaseWidgetState();
}

class _DropDownListFromDatabaseWidgetState
    extends State<DropDownListFromDatabaseWidget> {
  List<String?> listItems = [];
  String? selectedValue;
  bool isSelected = false;
  bool isUploading = false;
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {

    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(

      children: [

        FirebaseDatabaseQueryBuilder(
            query: FirebaseDatabaseMethods().reference(path: widget.databasePath),
            builder: (context, snapshot, _) {
              if (snapshot.isFetching) {

                return SizedBox(
                  height: 50,
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Fetching...'),
                            SizedBox(
                                width: Get.width * 0.5,

                            child: const LinearProgressIndicator()),
                          ],
                        ),
                  ),
                );
              } else if (snapshot.hasData) {
                listItems.clear();
                for (final child in snapshot.docs) {
                  listItems.add((child.value
                          as Map<dynamic, dynamic>)[widget.databaseVariable]
                      .toString()
                      );
                }
              }
              return GFSearchBar<String?>(
                controller: searchController,
                searchList: listItems,

                searchBoxInputDecoration:InputDecoration().copyWith(
                    hintText: (selectedValue ?? widget.hintText),
                    hintStyle: const TextStyle(color: Colors.black),
                    suffixIcon: const Icon(Icons.search),
                ),
                // InputDecoration(
                //
                //   hintText: (selectedValue ?? widget.hintText),
                //   hintStyle: const TextStyle(color: Colors.black),
                //   suffixIcon: const Icon(Icons.search),
                // ),
                noItemsFoundWidget: TextButton(
                    child: isUploading
                        ? LinearProgressIndicator()
                        : const Text(
                            'Item not found.\nDo you want to add to list?',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                    onPressed: () async {
                      setState(() {
                        isUploading = true;
                      });

                      String id = const Uuid().v1();
                      selectedValue = searchController.text.trim();
                      await FirebaseDatabaseMethods()
                          .addMapToDb(path: '${widget.databasePath}/$id', map: {
                        'name': searchController.text.trim(),
                      });
                      searchController.value = TextEditingValue(text: selectedValue!);
                      setState(() {
                        isUploading = false;
                      });
                    }),
                searchQueryBuilder: (query, list) {

                  return filterMethod(query);

                },
                overlaySearchListItemBuilder: (item) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      item.toString(),
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                },
                onItemSelected: (item) {
                  setState(() {
                    selectedValue = item.toString();
                  });

                  widget.onSelect(item.toString());
                },
              );
            }),
        Positioned(
            left: 35,
            top: 6,
            child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Text('Complain Category' , style: TextStyle(fontSize: 12),))),
      ],
    );
  }

  List<String?> filterMethod(searchText) {
    List<String?> filteredList = [];
    List<String?> tempList = listItems;
    List<String?> subWords = searchText.split(' ');
    for (int i = 0; i < subWords.length; i++) {
      tempList = tempList
          .where((element) => element
              .toString()
              .toLowerCase()
              .contains(subWords[i]!.toLowerCase()))
          .toList();
      filteredList  = tempList;
    }
    return filteredList .toSet().toList();
  }
}
