
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';
import 'package:searchable_listview/searchable_listview.dart';

import 'package:string_extensions/string_extensions.dart';
import 'package:uuid/uuid.dart';

import '../resources/firebase_database_methods.dart';

class DropDownListFromDatabaseScreen extends StatefulWidget {
  String hintText;
  String notSelectedDialogText;
  Function(String? selected) onSelect;
  bool isButtonVisible;
  Function(String value) onConfirm;
  String databasePath;
  String databaseVariable;

  DropDownListFromDatabaseScreen({
    Key? key,
    this.isButtonVisible = true,
    required this.hintText,
    required this.onSelect,
    required this.notSelectedDialogText,
    required this.onConfirm,
    required this.databasePath,
    required this.databaseVariable,
  }) : super(key: key);

  @override
  State<DropDownListFromDatabaseScreen> createState() =>
      _DropDownListFromDatabaseScreenState();
}

class _DropDownListFromDatabaseScreenState extends State<DropDownListFromDatabaseScreen> {
  TextEditingController searchController = TextEditingController();

  List listItems = [];
  String selectedValue = '';
  bool isSelected = false;

  @override
  void dispose() {

    super.dispose();
    searchController.dispose();
  }


  @override
  void initState() {
    super.initState();


  }

  void _onItemSelected<String>(String selected) {
    isSelected = true;

    widget.onSelect('$selected');
    searchController.value = TextEditingValue(text: '$selected');
  }

  void _onSubmitSearch(String? selected) async  {
    if (listItems.contains(selected!.toLowerCase())) {
      isSelected = true;
    } else {
      isSelected = false;
    }

    if (isSelected) {
      Get.back();
      widget.onSelect(
        selected,
      );

      searchController.clear();
    } else {
      await Get.dialog(
        _dialogWidget(),
        name: 'Add an Item to the list',
        barrierColor: Theme.of(context).primaryColor,
      );
    }
    widget.onConfirm(selected);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(widget.hintText)),
      body: FirebaseDatabaseQueryBuilder(
          query: FirebaseDatabaseMethods().reference(path: widget.databasePath),
          builder: (context, snapshot, _) {
            if (snapshot.isFetching) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              listItems.clear();
              for (final child in snapshot.docs) {
                listItems.add((child.value
                        as Map<dynamic, dynamic>)[widget.databaseVariable]
                    .toString()
                    .toLowerCase());
              }
            }
            return Center(
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          height: Get.height / 3,
                          child: SearchableList<dynamic>(
                            searchTextController: searchController,
                            onSubmitSearch: _onSubmitSearch,
                            onItemSelected: _onItemSelected,
                            inputDecoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                left: 15,
                                right: 10,
                              ),
                              hintText: widget.hintText,
                            ),
                            filter: filterMethod,
                            initialList: listItems,
                            builder: (value) {
                              final displayString = value.toString().toTitleCase;

                              return Container(
                                margin: const EdgeInsets.all(4),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Theme.of(context).primaryColor,
                                ),
                                child: Text(
                                  displayString!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Visibility(
                          visible: widget.isButtonVisible,
                          child: Wrap(
                            children: [
                              TextButton(
                                onPressed: () {
                                  String stl = 'Not yet';
                                  _onSubmitSearch(
                                      searchController.text.trim().toLowerCase());
                                 // Future.delayed(Duration(seconds: 10)).then((value) => stl = 'hello');


                                },
                                child: const Text('Confirm'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                  searchController.clear();
                                  widget.onSelect(null);
                                },
                                child: const Text('Cancel'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  SizedBox _dialogWidget(){
    return SizedBox(
      height: 200,
      child: Card(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'Do you want add ${searchController.text.trim()} to the list?'),
              TextButton(
                  onPressed: () async  {
                    String id = const Uuid().v1();
                    await FirebaseDatabaseMethods()
                        .addMapToDb(path: '${widget.databasePath}/$id', map: {
                      'name': searchController.text.trim().toLowerCase(),
                    });

                    widget.onSelect(searchController.text.trim());
                    listItems.add(searchController.text.trim().toLowerCase());
                    setState(() {});
                    Get.back();
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('No')),
            ],
          ),
        ),
      ),
    );
  }

  List<dynamic> filterMethod(searchText) {
    List filteredBreedList = [];
    List tempList = listItems;
    List<String> subWords = searchText.split(' ');
    for (int i = 0; i < subWords.length; i++) {
      tempList = tempList
          .where((element) => element
              .toString()
              .toLowerCase()
              .contains(subWords[i].toLowerCase()))
          .toList();
      filteredBreedList = tempList;
    }
    return filteredBreedList.toSet().toList();
  }
}
