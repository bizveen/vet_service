import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldX extends StatelessWidget {
  TextEditingController? controller;
  String label;
  Function()? onTap;
  bool enabled;
  Function(String)? onChanged;
  String? Function(String?)? validator;
  TextFieldX(
      {Key? key,
      this.controller,
      required this.label,
      this.onTap,
      this.onChanged,
      this.enabled = true,
        this.validator
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: validator,
        onChanged: onChanged,
        enabled: enabled,
        onTap: onTap,
        controller: controller,
        decoration: InputDecoration(label: Text(label , )),
      ),
    );
  }
}
