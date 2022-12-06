
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DecorationWidget extends StatelessWidget {
  Function() onAddPressed;
  String title;
  List<Widget>? children;
  DecorationWidget({Key? key , required this.title, required this.children, required this.onAddPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: Get.width,
          child: Row(
            mainAxisSize: MainAxisSize.min,


            children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title , style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold),),
              ),
              Expanded(child: Container(color: Colors.amber, height: 2,)),
              IconButton(onPressed: onAddPressed, icon: Icon(Icons.add, color: Colors.amber,))
            ],
          ),
        ),
       children != null ? Column(
          children: children!,
        ) : Container(),

      ],
    );
  }
}
