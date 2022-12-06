import 'package:flutter/material.dart';


class TextFieldX extends StatelessWidget {
  TextEditingController? controller;
  String? hintText;
  String? label;
  IconData icon;
  TextInputType? keybord;
  Widget? suffixWidget;
  void Function(String)? onChanged;
  VoidCallback? onTap;
  String? initialValue;
  bool enabled;

  TextFieldX(
      {Key? key,
      this.onChanged,
      this.suffixWidget,
      this.controller,
      this.hintText,
      this.label,
      required this.icon,
      this.keybord,
      this.onTap,
      this.initialValue,
      this.enabled = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        // height: 40,
        child: TextFormField(
          enabled: enabled,
          initialValue: initialValue,
          onTap: onTap,
          onChanged: onChanged,
          controller: controller,
          keyboardType: keybord,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              suffixIcon: suffixWidget,
              prefixIcon: Icon(
                icon,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8)),
              hintText: hintText,
              label: label != null ? Text(label!) : null),
        ),
      ),
    );
  }
}
