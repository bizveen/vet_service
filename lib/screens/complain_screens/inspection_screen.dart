import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/complain/OrganSystemInspections.dart';
import 'local_widgets/inspection_organ_system_input_widget.dart';

class InspectionScreen extends StatefulWidget {
  Map<dynamic, dynamic> inspectionMap;
   InspectionScreen({Key? key , required this.inspectionMap}) : super(key: key);

  @override
  State<InspectionScreen> createState() => _InspectionScreenState();
}

class _InspectionScreenState extends State<InspectionScreen> {
  List<OrganSystemInspections>? organSystemList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Inspection Screen"),),
      body:
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                  children:
                  widget.inspectionMap.keys.map((e) {
                    return InspectionOrganSystemInputWidget(
                      inspectionMap:widget.inspectionMap[e] , title: e,result: (result){
                      organSystemList!.add(result);

                    },);
                  }).toList()
              ),
            ),
          ),
          Expanded(child: Row(
            children: [
              ElevatedButton(onPressed: (){}, child: Text("Add"))
            ],
          ))

        ],
      ),
    );
  }
}
