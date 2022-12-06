
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

import '../resources/firebase_database_methods.dart';
import 'container_with_border.dart';

class DropDownListFromDatabaseWidgetMultiSelect extends StatefulWidget {
  DropDownListFromDatabaseWidgetMultiSelect(
      {Key? key,
      required this.databasePath,
      required this.databaseVariable,
      required this.hintText,
      required this.onConfirm,
       this.selectedValues
      })
      : super(key: key);
  String hintText;
  Function(List<String?>? selected) onConfirm;

  String databasePath;
  String databaseVariable;
  List<String>? selectedValues;

  @override
  State<DropDownListFromDatabaseWidgetMultiSelect> createState() =>
      _DropDownListFromDatabaseWidgetMultiSelectState();
}

class _DropDownListFromDatabaseWidgetMultiSelectState
    extends State<DropDownListFromDatabaseWidgetMultiSelect> {
  List<String> listItems = [];
  List<String>? selectedValues ;
  bool isSelected = false;
  bool isUploading = false;
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {

    super.dispose();
    searchController.dispose();
  }
@override
  void initState() {
    selectedValues = widget.selectedValues;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FirebaseDatabaseQueryBuilder(
            query:
                FirebaseDatabaseMethods().reference(path: widget.databasePath),
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
                      .toString());
                }
              }
              return ContainerWithBorder(
                child: MultiSelectDialogField<String>(
                  searchable: true,
                  initialValue: selectedValues!,
                  buttonText: Text(widget.hintText),
                  title: Expanded(
                    child: SizedBox(
                      child: Text(
                        widget.hintText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  items: listItems.map((e) => MultiSelectItem(e, e)).toList(),
                  listType: MultiSelectListType.CHIP,
                  separateSelectedItems: true,
                  chipDisplay: MultiSelectChipDisplay<String>(
                    onTap: (value) {
                      setState(() {
                        selectedValues!.remove(value);
                      });
                      widget.onConfirm(selectedValues);
                    },
                  ),
                  onConfirm: (values) {
                    setState(() {
                      selectedValues = values;
                    });
                    widget.onConfirm(selectedValues);
                  },
                ),
              );
            }),
      ],
    );
  }

  List<String> filterMethod(searchText) {
    List<String> filteredList = [];
    List<String> tempList = listItems;
    List<String> subWords = searchText.split(' ');
    for (int i = 0; i < subWords.length; i++) {
      tempList = tempList
          .where((element) => element
              .toString()
              .toLowerCase()
              .contains(subWords[i].toLowerCase()))
          .toList();
      filteredList = tempList;
    }
    return filteredList.toSet().toList();
  }
}
