import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';

class GFButtonWidget extends StatelessWidget {
  String? name;
  Color? color;
  Function() onPressed;
  int? animationDuration;
  Widget? child;

  GFButtonWidget(
      {Key? key,
      this.name,
      required this.onPressed,
      this.color,
      this.animationDuration,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFButton(
      animationDuration: Duration(microseconds: animationDuration ?? 400),
      color: color ?? Theme.of(context).primaryColor,
      shape: GFButtonShape.pills,
      elevation: 10,
      size: 40,
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        child: child ??
            Text(
              name ?? '',
              style:
                            TextStyle(fontSize: 16),
            ),
      ),
    );
  }
}
