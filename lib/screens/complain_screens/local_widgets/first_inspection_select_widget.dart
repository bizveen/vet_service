
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

import 'package:firebase_database/firebase_database.dart';
import '../../../models/complain/organ_system_inspections_result.dart';
import '../../../resources/firebase_database_methods.dart';
import '../../../utils/utils.dart';
import '../../../widgets/container_with_border.dart';



class FirstInspectionSelectWidgetMultiSelect extends StatefulWidget {
  FirstInspectionSelectWidgetMultiSelect(
      {Key? key,
      required this.databasePath,
      required this.databaseVariable,
      required this.hintText,
      required this.onConfirm,
       this.initialValues
      })
      : super(key: key);
  String hintText;
  Function(List<OrganSystemInspectionsResult?>? selected) onConfirm;

  String databasePath;
  String databaseVariable;
  List<OrganSystemInspectionsResult>? initialValues;

  @override
  State<FirstInspectionSelectWidgetMultiSelect> createState() =>
      _FirstInspectionSelectWidgetMultiSelectState();
}

class _FirstInspectionSelectWidgetMultiSelectState
    extends State<FirstInspectionSelectWidgetMultiSelect> {
  List<OrganSystemInspectionsResult> listItems = [];
  List<OrganSystemInspectionsResult>? selectedValues ;
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
   // selectedValues = widget.initialValues;
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
                  listItems.add(OrganSystemInspectionsResult(
                      id: child.key,
                    name: dataSnapShotListToMap(children: child.children)['name'],
                  ));
                }
              }
              return ContainerWithBorder(
                child: MultiSelectDialogField<OrganSystemInspectionsResult>(
                  searchable: true,
                  initialValue: selectedValues!,
                  buttonText: Text(widget.hintText),
                  title: SizedBox(
                    child: Text(
                      widget.hintText,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  items: listItems.map((e) => MultiSelectItem(e, e.name!)).toList(),
                  listType: MultiSelectListType.CHIP,
                  separateSelectedItems: true,
                  chipDisplay: MultiSelectChipDisplay<OrganSystemInspectionsResult>(

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

  List<OrganSystemInspectionsResult> filterMethod(searchText) {
    List<OrganSystemInspectionsResult> filteredList = [];
    List<OrganSystemInspectionsResult> tempList = listItems;
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
