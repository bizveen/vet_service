
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../resources/firebase_database_methods.dart';

class EditUsingTextFieldWidget extends StatefulWidget {
  Widget child;
  List<String> pathList;
  String variable;
  String id;
  double iconPositionRight;
  double iconPositionBottom;
  double width;
  double height;
   EditUsingTextFieldWidget({Key? key,
     required this.child, required this.pathList,
     required this.variable, required this.id,
     this.width = double.infinity,
     this.height = 100,
      this.iconPositionRight = 0,
     this.iconPositionBottom = 0,

   }) : super(key: key);

  @override
  State<EditUsingTextFieldWidget> createState() => _EditUsingTextFieldWidgetState();
}

class _EditUsingTextFieldWidgetState extends State<EditUsingTextFieldWidget> {
  TextEditingController editController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Row(
mainAxisSize: MainAxisSize.min,


        children: [
          widget.child,
          Positioned(
            right:widget.iconPositionRight,
              bottom: widget.iconPositionBottom,
              child: IconButton(icon : Icon(Icons.edit_note),iconSize: 30, onPressed: ()async{
           Map<dynamic,dynamic> map = await FirebaseDatabaseMethods().getMapFromPath(path:'${widget.pathList[0]}/${widget.id}');
           editController.value= TextEditingValue(text:map[widget.variable] );

            Get.defaultDialog(

              title: 'Edit',
              content: TextFormField(
                controller: editController,
              ),
              onConfirm: ()async{
               await FirebaseDatabaseMethods().updateBatch( pathListToUpdatableMap(id: widget.id, updatingValue: [editController.text.trim()], pathList: widget.pathList,variables: [widget.variable] ));
Get.back();
              }

            );
          },))
        ],
      ),
    );
  }
  
}
