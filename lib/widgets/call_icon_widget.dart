

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';

import '../models/log.dart';
import '../resources/database_object_paths/log_paths.dart';
import '../resources/firebase_database_methods.dart';

class CallIconWidget extends StatefulWidget {
  CallIconWidget({
    Key? key,
    this.calledFor,
     required this.clientId,
    this.vaccinationPath,
    this.complainPath,
    this.vaccinationId,
    this.complainId,
    required this.contactNo,
    required this.logType,
    required this.petId,
  }) : super(key: key);
LogType logType;
String? petId;
  String? calledFor;
  String? clientId;
  String? vaccinationId;
  String? complainId;
  String? vaccinationPath;
  String? complainPath;
String? contactNo;

  @override
  State<CallIconWidget> createState() => _CallIconWidgetState();
}

class _CallIconWidgetState extends State<CallIconWidget> {
bool notifyDoctor = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController commentController = TextEditingController();
    return IconButton(
      icon: Icon(Icons.call),
      onPressed: () async {
        bool? callingStatus = false;

        callingStatus = await FlutterPhoneDirectCaller.callNumber(widget.contactNo!);

        Get.defaultDialog(


          onConfirm: () async {
            await FirebaseDatabaseMethods().createLastCallLog(
              petId: widget.petId,
                calledFor: widget.calledFor,
                comment: commentController.text,
               complainId: widget.complainId,
            vaccinationPath: widget.vaccinationPath,
              complainPath: widget.complainPath,
              vaccinationId: widget.vaccinationId,
              clientId: widget.clientId,
              logType: widget.logType
            );

            Get.back();
          },
          onCancel: ()async{
            await FirebaseDatabaseMethods().createLastCallLog(
            petId: widget.petId,
              logType: widget.logType,
                calledFor: widget.calledFor,
                comment: '',
                complainId: widget.complainId,
                vaccinationPath: widget.vaccinationPath,
                complainPath: widget.complainPath,
                vaccinationId: widget.vaccinationId,
                clientId: widget.clientId
            );
            Get.back();
          },
          barrierDismissible: false,
          content: StatefulBuilder(
            builder: (context , innerSetState) {
              return FutureBuilder(
                  future: Future.delayed(const Duration(seconds: 3)),
                  builder: (context, snapshot) {
                    return
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(child: Text('Add Comment', style: Get.textTheme.headline6,)),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Notify Doctor', style: Get.textTheme.bodySmall!,),
                                  Checkbox(

                                      value: notifyDoctor, onChanged: (value){
                                        innerSetState((){
                                          notifyDoctor=!notifyDoctor;
                                        });


                                      }),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: TextField(
                                  enableSuggestions: true,
                                  controller: commentController,
                                ),
                              ),


                            ],
                          ),
                        ],
                      );
                  });
            }
          ),
        );
      },
    );
  }
}
