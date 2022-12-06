import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextSmallTitle extends StatelessWidget {
  String text;
   TextSmallTitle(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(text, style: TextStyle(fontWeight: FontWeight.bold
      ), ),
    );
  }
}
