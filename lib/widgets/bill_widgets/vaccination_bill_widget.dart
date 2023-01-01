
import 'package:flutter/material.dart';
import 'package:string_extensions/string_extensions.dart';

import '../../models/sale/Invoice.dart';
import 'bill_row_header_widget.dart';

class VaccinesBillWidget extends StatefulWidget {
  Invoice sale;
   VaccinesBillWidget({Key? key , required this.sale}) : super(key: key);

  @override
  State<VaccinesBillWidget> createState() => _VaccinesBillWidgetState();
}

class _VaccinesBillWidgetState extends State<VaccinesBillWidget> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(

        title:  BillRowHeaderWidget(
          title: 'Vaccines',
          qty: widget.sale.vaccineList!.length,
          value: widget.sale.getTotalChargesForVaccinations(),),
      children: [
        widget.sale.vaccineList != null ? ListView.builder(
          shrinkWrap: true,
          itemCount: widget.sale.vaccineList!.length,
            itemBuilder: (context , index){
            
            return ListTile(
              title:
              BillRowHeaderWidget(
                  title:  widget.sale.vaccineList![index]!.name!,
                  qty: 1,
                  value: widget.sale.vaccineList![index]!.retailPrice!.toDouble(),
              ),

            );
            }) : Container(),
      ],
    );

  }
}
