

// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatefulWidget {
  String buttonText;
  String? datePrefix;
  DateTime? defaultDateTime;
  final Function(DateTime) pickedDate;

  DatePickerWidget({
    Key? key,
    required this.buttonText,
    required this.pickedDate,
    this.defaultDateTime,
    this.datePrefix,
  }) : super(key: key);

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? dateLabel ;
  DateFormat formatter = DateFormat('yyyy/MM/dd');

  @override
  void initState() {
    dateLabel = widget.defaultDateTime ?? DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisSize: MainAxisSize.min,
        children: [
      TextButton(
        onPressed: () async{
          DateTime? date = await showDatePicker(
            context: context,
            firstDate: DateTime(2005, 1, 1),
            initialDate: DateTime.now(),
            lastDate: DateTime(2050, 1, 1),
            selectableDayPredicate: (DateTime date) {
              return date != DateTime(2022, 04, 06);
            },
            fieldHintText: 'Vaccine Given Date',
            fieldLabelText: 'Given Vaccine Date',
            helpText: 'What is your Given date?',
          );
          if (date != null) {
            dateLabel = date;
            widget.pickedDate(dateLabel ?? DateTime.now());
            setState(() {});
          }
        },
        child: Text(
          '${widget.datePrefix ?? ''}  ${formatter.format(dateLabel!).toString()}',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor),
        ),
      ),
        //child: FittedBox(child: Text(widget.buttonText)),

    ]);
  }
}
