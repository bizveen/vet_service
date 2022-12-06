
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:string_extensions/string_extensions.dart';

class ContactNoInputRow extends StatelessWidget {
  TextEditingController controller;
  String label;
  VoidCallback addPress;
  VoidCallback removePress;
  bool showPlusButton;
  bool showMinusButton;

  ContactNoInputRow({Key? key,
    required this.label,
    required this.controller,
    required this.addPress,
    required this.removePress,
    this.showMinusButton = true,
    this.showPlusButton = true,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: TextFormField(
              validator: (value){
              // return (!value.isNumber).toString();
              },
              controller: controller,
              decoration: InputDecoration(label: Text(label)),)),
            showMinusButton ? IconButton(
                icon: const Icon(
                  Icons.remove,
                  color: Colors.red,
                ),
                onPressed: removePress) : Container(),
            showPlusButton ? IconButton(
                icon: const Icon(
                  Icons.add,
                  color: Colors.green,
                ),
                onPressed: addPress) : Container(),



          ],
        ),
      ),
    );
  }
}
