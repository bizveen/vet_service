import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ContainerWithBorder extends StatelessWidget {
  Widget? child;
  double? height;
  double? width;
   ContainerWithBorder({Key? key,
    this.width, this.height , this.child

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        clipBehavior: Clip.antiAlias,
        child: child,
        width: width ?? Get.size.width,
        height: height ,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)),
      ),
    );
  }
}
