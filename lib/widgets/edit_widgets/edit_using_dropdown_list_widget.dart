
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../resources/firebase_database_methods.dart';
import '../drop_down_list_from_databse_widget.dart';

class EditUsingDropdownListWidget extends StatefulWidget {
  Widget child;
  List<String> pathList;
  String variable;
  String id;
  double iconPositionRight;
  double iconPositionBottom;
  double width;
  double height;
  String databaseListPath;
  String databaseListVariable;
  String hintText;

   EditUsingDropdownListWidget({Key? key,
     required this.child, required this.pathList,
     required this.variable, required this.id,
     required this.databaseListPath,
     required this.databaseListVariable,
     required this.hintText,

     this.width = double.infinity,
     this.height = 100,
      this.iconPositionRight = 0,
     this.iconPositionBottom = 0,

   }) : super(key: key);

  @override
  State<EditUsingDropdownListWidget> createState() => _EditUsingDropdownListWidgetState();
}

class _EditUsingDropdownListWidgetState extends State<EditUsingDropdownListWidget> {
 late String selectedValue;
 @override
  void initState() {

    super.initState();
  }
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
setState((){
  selectedValue = map[widget.variable];
});

            Get.defaultDialog(

              title: 'Edit',
              content: DropDownListFromDatabaseWidget(
                  databasePath: widget.databaseListPath,
                  databaseVariable: widget.databaseListVariable, hintText: widget.hintText, onSelect: (value){
                    setState(() {
                      selectedValue = value!;
                    });
              }),
              onConfirm: ()async{
               await FirebaseDatabaseMethods().updateBatch( pathListToUpdatableMap(id: widget.id, updatingValue: [selectedValue], pathList: widget.pathList,variables: [widget.variable] ));
Get.back();
              }

            );
          },))
        ],
      ),
    );
  }
  
}
