
import 'package:flutter/material.dart';

import '../../models/sale/Sale.dart';
import '../../models/sale/inventory_out.dart';
import 'bill_row_header_widget.dart';

class ProductBillWidget extends StatefulWidget {
  Sale sale;
   ProductBillWidget({Key? key , required this.sale}) : super(key: key);

  @override
  State<ProductBillWidget> createState() => _ProductBillWidgetState();
}

class _ProductBillWidgetState extends State<ProductBillWidget> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(

        title:     BillRowHeaderWidget(
          title:  'Products',
          qty:  widget.sale.inventoryOutList!.length,
          value:widget.sale.getTotalChargesForProducts()),
      children: [
       // BillTable(inventoryOut: widget.sale.inventoryOutList!)
        widget.sale.inventoryOutList != null ? ListView.builder(
          shrinkWrap: true,
          itemCount: widget.sale.inventoryOutList!.length,
            itemBuilder: (context , index){
            return ListTile(
              title:
              BillRowHeaderWidget(
                title:  widget.sale.inventoryOutList![index]!.product!.name!,
                qty: widget.sale.inventoryOutList![index]!.qty,
                value:widget.sale.inventoryOutList![index]!.retailPrice!.toDouble(),),


            );
            }) : Container()
      ],
    );

  }
}
