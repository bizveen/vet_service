
import 'package:flutter/material.dart';

import '../../../models/complain/Complain.dart';
import '../../../widgets/container_with_border.dart';
import 'decoration_widget.dart';

class FirstInspectionDetailsWidget extends StatelessWidget {
   FirstInspectionDetailsWidget({
    Key? key,
    required this.onPressed,
    required this.complain,
  }) : super(key: key);

  final Complain complain;
 Function() onPressed;
  @override
  Widget build(BuildContext context) {


    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecorationWidget(
          title: 'First Inspection',
          children:[complain.getFirstInspectionSummery(),] ,
          onAddPressed: onPressed,
        )
      ],
    );
  }
}
