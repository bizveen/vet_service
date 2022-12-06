import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderText extends StatelessWidget {
  String text;
  HeaderText({Key? key , required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text , style: Get.textTheme.headline2,
    );
  }
}
