import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonX extends StatelessWidget {
  String text;
  VoidCallback? onTap;

  ButtonX({Key? key, required this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).backgroundColor,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Container(
          width: Get.width,
          child: Center(
              child: Text(
            text,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          )),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          height: 50,
        ),
      ),
    );
  }
}
