
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:uuid/uuid.dart';

import '../../../models/complain/OrganSystemInspections.dart';
import '../../../models/complain/organ_system_inspections_result.dart';

class InspectionOrganSystemInputWidget extends StatefulWidget {
  Map<dynamic, dynamic> inspectionMap;
  String title;
  Function(OrganSystemInspections) result;

  InspectionOrganSystemInputWidget(
      {Key? key,
      required this.inspectionMap,
      required this.title,
      required this.result})
      : super(key: key);

  @override
  State<InspectionOrganSystemInputWidget> createState() =>
      _InspectionOrganSystemInputWidgetState();
}

class _InspectionOrganSystemInputWidgetState
    extends State<InspectionOrganSystemInputWidget> {
  late List<OrganSystemInspectionsResult> resultsList = [];
  late List<TextEditingController> commentControllers;
  late OrganSystemInspections organSystemInspections;
  @override
  void initState() {
    commentControllers = List.generate(
        widget.inspectionMap.length, (index) => TextEditingController());
    widget.inspectionMap.forEach((key, value) {
      resultsList.add(OrganSystemInspectionsResult.fromJson(
          value as Map<dynamic, dynamic> , key));
    });
    organSystemInspections = OrganSystemInspections(
      organSystem: widget.title,
        id: Uuid().v1(),
        results: resultsList);
    super.initState();
  }
@override
  void dispose() {
    commentControllers.forEach((element) {element.dispose();});
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Text(widget.title),
        Column(
            children: List.generate(
                resultsList.length,
                (index) => GFCheckboxListTile(
                    subTitle: Visibility(
                        visible: resultsList[index].isSelected!,
                        child: TextField(
                          controller: commentControllers[index],
                          onChanged: (value){
                            resultsList[index]=  resultsList[index].copyWith(comment: value.trim());
                            widget.result(organSystemInspections.copyWith(results: resultsList));
                          },
                        )),
                    title: Text(resultsList[index].name!),
                    value: resultsList[index].isSelected!,
                    onChanged: (value) {
                      setState(() {
                        resultsList[index].isSelected =
                            !resultsList[index].isSelected!;

                      });
                      resultsList[index]=  resultsList[index].copyWith(comment: commentControllers[index].text.trim());
                      widget.result(organSystemInspections.copyWith(results: resultsList));
                    }))),
      ],
    );
  }
}
