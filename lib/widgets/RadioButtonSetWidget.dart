import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RadioButtonSet extends StatefulWidget {
  final List<String> options;
  final Function(String) onChanged;

  RadioButtonSet({required this.options, required this.onChanged});

  @override
  _RadioButtonSetState createState() => _RadioButtonSetState();
}

class _RadioButtonSetState extends State<RadioButtonSet> {
  dynamic _selectedOption = "Mr.";

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: widget.options.map((option) {
        return SizedBox(
          width: Get.width/3,
          child: RadioListTile(

            title: Text(option),
            value: option,
            groupValue: _selectedOption,
            onChanged: (value) {
              setState(() {
                _selectedOption = value;
              });
              widget.onChanged(value as String);
            },
          ),
        );
      }).toList(),
    );
  }
}