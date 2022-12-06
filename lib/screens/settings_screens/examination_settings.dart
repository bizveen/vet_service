
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../constants.dart';
import '../../resources/firebase_database_methods.dart';
import '../../widgets/text_field_x.dart';

class ExaminationSettings extends StatefulWidget {
  const ExaminationSettings({Key? key}) : super(key: key);

  @override
  State<ExaminationSettings> createState() => _ExaminationSettingsState();
}

class _ExaminationSettingsState extends State<ExaminationSettings> {
  TextEditingController addSystemController = TextEditingController();
  @override
  void dispose() {

    super.dispose();
    addSystemController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
Get.defaultDialog(content: TextField(
  controller: addSystemController,

),
confirm: TextButton(onPressed: ()async{
  String id = const Uuid().v1();
  FirebaseDatabaseMethods().updateBatch({
    '$examinationCategoriesPath/${addSystemController.text.trim()}/$id/name' : 'Appears Normal'
  });
  Get.back();
  addSystemController.clear();
}, child: const Text('Add System')));

        },
        child: const Text('+ System' , textAlign: TextAlign.center),
      ),
      appBar: AppBar(
        title: const Text('Examination Settings'),
      ),
      body: FirebaseDatabaseListView(
          query: FirebaseDatabaseMethods().reference(
              path: '$examinationCategoriesPath/'
          ), itemBuilder: ( context, snapshot) {
            return ExaminationValuesWidget(system: snapshot.key! , tableLength: snapshot.children.length,);
      },
        ),
    );
  }
}

class ExaminationValuesWidget extends StatefulWidget {
  String system;
  int tableLength;

  ExaminationValuesWidget({
    Key? key,
    required this.system,
    required this.tableLength,
  }) : super(key: key);

  @override
  State<ExaminationValuesWidget> createState() =>
      _ExaminationValuesWidgetState();
}

class _ExaminationValuesWidgetState extends State<ExaminationValuesWidget> {
  TextEditingController addValueController = TextEditingController();

  @override
  void dispose() {

    super.dispose();
    addValueController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FirebaseDatabaseDataTable(

        header: Text('${widget.system} Signs'),
        query: FirebaseDatabaseMethods().reference(
            path: '$examinationCategoriesPath/${widget.system}'
                ),
        columnLabels: const {
          'name': Text('Name'),
        },
        rowsPerPage: widget.tableLength >5 ? 5 : widget.tableLength,
        actions: [
          IconButton(
              onPressed: () {
                Get.defaultDialog(
                    title: 'Add ${widget.system} value',
                    confirm: TextButton(
                      onPressed: () async {
                        String id = const Uuid().v1();
                        FirebaseDatabaseMethods().updateBatch({
                          '$examinationCategoriesPath/${widget.system}/$id/name':
                              addValueController.text.trim()
                        });
                        Get.back();
                        addValueController.clear();
                      },
                      child: const Text('Add'),
                    ),
                    cancel: TextButton(onPressed: (){
                      Get.back();
                    }, child: const Text('Cancel')),
                    content: Column(
                      children: [
                        TextFieldX(
                          label: 'Add ${widget.system} value',
                          controller: addValueController,
                        )
                      ],
                    ));
              },
              icon: const Icon(Icons.add))
        ],
        canDeleteItems: true,
      ),
    );
  }
}
