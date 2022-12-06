
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:fluttericon/modern_pictograms_icons.dart';
import 'package:get/get.dart';
import 'package:string_extensions/string_extensions.dart';

import '../resources/firebase_database_methods.dart';

class ValueFromDatabaseWidget extends StatefulWidget {
  String path;
  String value;
  String? prefixText;
  double fontSize;
  Color textColor;
  String label;

  ValueFromDatabaseWidget({Key? key,
    required this.path,
    required this.value,
    this.prefixText,
    this.fontSize = 14,
    this.textColor = Colors.black,
    required this.label
  })
      : super(key: key) ;

  @override
  State<ValueFromDatabaseWidget> createState() =>
      _ValueFromDatabaseWidgetState();
}

class _ValueFromDatabaseWidgetState extends State<ValueFromDatabaseWidget> {
  TextEditingController editController = TextEditingController();

  @override
  void dispose() {

    super.dispose();
    editController.dispose();
  }

  Map<dynamic, dynamic> map = {};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
       width: Get.width*0.8,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20),),
          border: Border.all( color: Colors.black12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                  child: Text(widget.label)),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FirebaseDatabaseQueryBuilder(
                      query: FirebaseDatabaseMethods().reference(path: widget.path),
                      builder: (context, snapshot, _) {
                        if (snapshot.isFetching) {
                          return const CircularProgressIndicator();
                        } else {
                          for (var element in snapshot.docs) {
                            map[element.key] = element.value;
                          }
                          return  Text(('${map[widget.value] ?? 'Add'}')
                              .toString()
                              .toTitleCase!, style: TextStyle(
                              fontSize: widget.fontSize, color: widget.textColor),) ;
                        }
                      }),
                  IconButton(

                    icon: const Icon(ModernPictograms.edit, size: 20),

                    color: Colors.blue,

                    onPressed: () {
                      editDialog('Edit ${widget.label}?');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> editDialog(String title) {
    return Get.dialog(
                      Card(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                    child: Text(title)),
                                const SizedBox(height: 10,),
                                TextField(
                                  controller: editController,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        FirebaseDatabaseMethods().updateBatch({
                                          '${widget.path}/${widget.value}':
                                          editController.text.trim()
                                        });
                                        Get.back();
                                      },
                                      child: const Text('Save'),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: const Text('cancel')),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      name: 'Edit',
                    );
  }
}
