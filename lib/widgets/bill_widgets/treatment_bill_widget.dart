
import 'package:flutter/material.dart';

import '../../models/sale/Sale.dart';
import 'bill_row_header_widget.dart';

class TreatmentBillWidget extends StatefulWidget {
  Sale sale;
   TreatmentBillWidget({Key? key , required this.sale}) : super(key: key);

  @override
  State<TreatmentBillWidget> createState() => _TreatmentBillWidgetState();
}

class _TreatmentBillWidgetState extends State<TreatmentBillWidget> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(

        title:  BillRowHeaderWidget(
          title:  'Treatments',
          qty: widget.sale.treatmentList!.length,
          value: widget.sale.getTotalChargesForTreatments(),),
      children: [
        widget.sale.treatmentList != null ? ListView.builder(
          shrinkWrap: true,
          itemCount: widget.sale.treatmentList!.length,
            itemBuilder: (context , index){
            return ListTile(
              title:
              BillRowHeaderWidget(
                  title:  widget.sale.treatmentList![index]!.getTreatmentTitle()!,
                  qty: 1,
                  value: widget.sale.treatmentList![index]!.charges!.toDouble(),),

              // Row(
              //   children: [
              //     Text(),
              //     Text(),
              //   ],
              // ),

            );
            }) : Container(),
      ],
    );

  }
}
