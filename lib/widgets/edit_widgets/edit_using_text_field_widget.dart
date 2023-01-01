
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_service/resources/firebase_firestore_methods.dart';

import '../../constants.dart';
import '../../resources/firebase_database_methods.dart';

class EditUsingTextFieldWidget extends StatefulWidget {
  Widget child;
  String clientId;
  String ? petId;
  String ? vaccinationId;
  String ? complainId;
  String variable;
  String label;
bool isEditing;
  double iconPositionRight;
  double iconPositionBottom;
  double width;
  double height;
   EditUsingTextFieldWidget({Key? key,
     required this.child,
     required this.variable,
     this.width = double.infinity,
     this.height = 100,
     this.isEditing = true,
      this.iconPositionRight = 0,
     this.iconPositionBottom = 0,
required this.clientId,
     this.complainId,
     this.petId,
     this.vaccinationId,
     required this.label
   }) : super(key: key);

  @override
  State<EditUsingTextFieldWidget> createState() => _EditUsingTextFieldWidgetState();
}

class _EditUsingTextFieldWidgetState extends State<EditUsingTextFieldWidget> {
  TextEditingController editController = TextEditingController();
  String subpath = '';
  @override
  Widget build(BuildContext context) {
    if(widget.complainId!=null) {
      subpath = 'pets.${widget.petId}.complains.${widget.complainId}.${widget.variable}';
    } else if(widget.vaccinationId!=null){
      subpath = 'pets.${widget.petId}.vaccinations.${widget.vaccinationId}.${widget.variable}';
    }else if(widget.petId!=null) {
      subpath = 'pets.${widget.petId}.${widget.variable}';
    }else{
      subpath = widget.variable;
    }

    return
      ConstrainedBox(
      constraints: BoxConstraints(maxWidth: widget.width , maxHeight: widget.height ),
      
        child: FittedBox(
        child: Row(
mainAxisSize: MainAxisSize.min,


          children: [
            widget.child,
            Positioned(
              right:widget.iconPositionRight,
                bottom: widget.iconPositionBottom,
                child:
                Visibility(
                  visible: widget.isEditing,
                  child: IconButton(icon : Icon(Icons.edit_note),iconSize: 30, onPressed: ()async{
             editController.value= TextEditingValue(text:widget.label );

              Get.defaultDialog(

                  title: 'Edit',
                  content: TextFormField(
                    controller: editController,
                  ),
                  onConfirm: ()async{
                   await FirebaseFirestoreMethods().firestore.collection('clients').doc(widget.clientId)
                       .update({subpath : editController.text.trim()});
Get.back();
                  }

              );
            },),
                ))
          ],
        ),
    ),
      );
  }

}
