import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../models/Pet.dart';

class PetTimeLine extends StatelessWidget {
  Pet pet;

  PetTimeLine({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0.3,
          //  isFirst: true,
            hasIndicator: true,
          indicatorStyle: IndicatorStyle(color:Colors.orange, indicator: Icon(Icons.abc)),
            endChild: Text('Born'),
            startChild: SizedBox(
              height: 50,
                child: Text('Vaccinated')),
             ),

          TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0.3,
          ),
        ],
      ),
    );
  }
}
