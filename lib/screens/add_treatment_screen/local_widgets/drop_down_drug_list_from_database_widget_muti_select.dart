
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:vet_service/screens/add_treatment_screen/add_treatment_screen_controller.dart';


import '../../../models/complain/Drug.dart';
import '../../../resources/firebase_database_methods.dart';
import '../../../widgets/container_with_border.dart';

class DropDownDrugListFromDatabaseWidgetMultiSelect extends StatefulWidget {
  DropDownDrugListFromDatabaseWidgetMultiSelect(
      {Key? key,
      required this.databasePath,
      required this.databaseVariable,
      required this.hintText,
      required this.onConfirm})
      : super(key: key);
  String hintText;
  Function(List<Drug>? selected) onConfirm;

  String databasePath;
  String databaseVariable;

  @override
  State<DropDownDrugListFromDatabaseWidgetMultiSelect> createState() =>
      _DropDownDrugListFromDatabaseWidgetMultiSelectState();
}

class _DropDownDrugListFromDatabaseWidgetMultiSelectState
    extends State<DropDownDrugListFromDatabaseWidgetMultiSelect> {
  List<Drug> listItems = [];
  List<Drug>? selectedValues;
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
                  Drug drug = Drug.fromJson(child.value as Map<dynamic , dynamic>);
                  listItems.add(drug);
                }
              }
              return ContainerWithBorder(

                child: MultiSelectDialogField<Drug>(
                   key: GlobalKey(debugLabel: "Drug List Item"),
                  searchable: true,
                  initialValue: Get.find<AddTreatmentScreenController>().selectedDrugsList.value,
                  buttonText: Text(widget.hintText),
                  title: Text(
                    widget.hintText,
                    overflow: TextOverflow.ellipsis,
                  ),
                  items: listItems.map((e) =>
                      MultiSelectItem(e, e.name! ,)).toList(),
                  listType: MultiSelectListType.CHIP,
                  separateSelectedItems: true,
                  chipDisplay: MultiSelectChipDisplay<Drug>(

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

  List<Drug> filterMethod(searchText) {
    List<Drug> filteredList = [];
    List<Drug> tempList = listItems;
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
