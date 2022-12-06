import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:string_extensions/string_extensions.dart';

import '../../models/Weight.dart';

class WeightChartScreen extends StatelessWidget {
  final List<Weight?> weightList;

  final bool animate;

  WeightChartScreen({ this.animate = true, required this.weightList});

  /// Creates a [TimeSeriesChart] with sample data and no transition.


  @override
  Widget build(BuildContext context) {
    weightList.sort((a, b) {
      return (a!.date! - b!.date!);
    },);


    return Card(

      child: SizedBox(
        height: 200,

        child: charts.TimeSeriesChart(

          behaviors: [
            charts.ChartTitle('Weight Chart', ),
            charts.ChartTitle('Time', behaviorPosition: charts.BehaviorPosition.bottom,
                titleStyleSpec: charts.TextStyleSpec(fontSize: 14) ),


          ],
          primaryMeasureAxis: charts.NumericAxisSpec(showAxisLine: true),
          [
            charts.Series<Weight?, DateTime>(

              id: 'Weight',
              colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
              domainFn: (Weight? w, _) =>
                  DateTime.fromMicrosecondsSinceEpoch(w!.date!),
              measureFn: (Weight? w, _) => w!.weight.toNum(),
              data: weightList,
              displayName: 'Weight Chart',
              seriesCategory: 'Weight'

            )
          ],
          animate: animate,

          // Optionally pass in a [DateTimeFactory] used by the chart. The factory
          // should create the same type of [DateTime] as the data provided. If none
          // specified, the default creates local date time.
          dateTimeFactory: const charts.LocalDateTimeFactory(),
        ),
      ),
    );
  }
}