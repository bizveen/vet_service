import 'package:flutter/material.dart';

class BillRowHeaderWidget extends StatefulWidget {
  String title;
  int? qty;
  double? value;
   BillRowHeaderWidget({Key? key , required this.title , this.qty , this.value}) : super(key: key);

  @override
  State<BillRowHeaderWidget> createState() => _BillRowHeaderWidgetState();
}

class _BillRowHeaderWidgetState extends State<BillRowHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 3,
            child: Text(widget.title)),

        Expanded(child: widget.qty!=  null ? Text(widget.qty!.toString()) : Container()),

        Expanded(flex: 2,
            child: Text(widget.value!.toStringAsFixed(2))),
      ],
    );
  }
}
