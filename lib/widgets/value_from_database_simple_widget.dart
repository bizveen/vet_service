
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:fluttericon/modern_pictograms_icons.dart';
import 'package:get/get.dart';

import '../resources/firebase_database_methods.dart';

class ValueFromDatabaseSimpleWidget extends StatefulWidget {
  String path;
  String value;
  int maxLines;

  double fontSize;
  Color textColor;
  String label;
  Function()? onSave;

  ValueFromDatabaseSimpleWidget(
      {Key? key,
        this.onSave,
      required this.path,
      required this.value,
      this.maxLines = 1,
      this.fontSize = 14,
      this.textColor = Colors.black,
      required this.label})
      : super(key: key);

  @override
  State<ValueFromDatabaseSimpleWidget> createState() =>
      _ValueFromDatabaseSimpleWidgetState();
}

class _ValueFromDatabaseSimpleWidgetState
    extends State<ValueFromDatabaseSimpleWidget> {
  TextEditingController editController = TextEditingController();
  Map<dynamic, dynamic> map = {};

  @override
  void dispose() {

    super.dispose();
    editController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FirebaseDatabaseQueryBuilder(
            query: FirebaseDatabaseMethods().reference(path: widget.path),
            builder: (context, snapshot, _) {
              if (snapshot.isFetching) {
                return SizedBox(
                    width: Get.width * 0.3,
                    child: const LinearProgressIndicator());
              } else {
                for (var element in snapshot.docs) {
                  map[element.key] = element.value;
                }
                return Text(
                  ('${map[widget.value] ?? widget.label}').toString(),
                  style: TextStyle(
                      fontSize: widget.fontSize, color: widget.textColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: widget.maxLines,
                );
              }
            }),
        IconButton(
          icon: const Icon(ModernPictograms.edit, size: 20),
          color: Colors.blue,
          onPressed: () async {
            await editDialog('Edit ${widget.label}?');
          },
        ),
      ],
    );
  }

  Future<dynamic> editDialog(String title) {
    editController.value = TextEditingValue(text: map[widget.value] ?? '');
    return Get.dialog(
      Card(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(alignment: Alignment.centerLeft, child: Text(title)),
                const SizedBox(
                  height: 10,
                ),
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
                        if (widget.onSave != null) {
                          widget.onSave!();
                        }
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
