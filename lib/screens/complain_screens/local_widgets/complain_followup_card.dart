

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:string_extensions/string_extensions.dart';

import '../../../models/complain/Complain.dart';
import '../../../resources/database_object_paths/complain_paths.dart';
import '../../../resources/firebase_database_methods.dart';
import '../../../utils/utils.dart';
import '../../../widgets/date_picker_widget.dart';
import '../complain_details_screen.dart';

class ComplainFollowupCard extends StatefulWidget {
  Complain complain;
  bool highlight;
  ComplainStatus complainStatus;

  ComplainFollowupCard(
      {Key? key, required this.complain, this.highlight = false, required this.complainStatus})
      : super(key: key);

  @override
  State<ComplainFollowupCard> createState() => _ComplainFollowupCardState();
}

class _ComplainFollowupCardState extends State<ComplainFollowupCard> {
  bool treatmentButtonVisible = true;
  bool firstInspectionButtonVisible = true;
  bool dDButtonVisible = true;
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Row(
          children: [
            Expanded(flex : 1, child: Container()),
            Expanded(flex : 4, child: Column(
              children: [
                Text(widget.complain.clientName ?? 'No Client Name'),
                Text(widget.complain.getTitle()),

              ],
            )),
            Expanded(flex : 1, child: Container(
              color: Colors.greenAccent,
              child: Center(child: Icon(Icons.arrow_circle_right_outlined, color: Get.theme.backgroundColor,)),
            )),

          ],
        ),
      ),
    );
  }
}
