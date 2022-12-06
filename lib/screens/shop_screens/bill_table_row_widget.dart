import 'package:flutter/material.dart';

class BillTableRowWidget extends TableRow {
  String item;
  int qty;
  double price;

   BillTableRowWidget({LocalKey? key, required this.item, required this.qty, required this.price,
     })
       : super(key: key, children: [
         SizedBox(height: 50,
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text(item),
             )),
     Align(
       alignment: Alignment.centerLeft,
       child: Padding(

         padding: const EdgeInsets.all(8.0),
         child: Text(qty.toString()),
       ),
     ),
     Padding(
       padding: const EdgeInsets.all(8.0),
       child: Text(price.toString()),
     ),
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: Text((qty*price).toString()),
       ),

   ],);




}
