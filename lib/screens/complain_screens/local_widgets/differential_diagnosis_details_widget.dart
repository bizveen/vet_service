
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../../constants.dart';
import '../../../models/complain/Complain.dart';
import '../../../models/complain/DifferentialDiagnosis.dart';
import '../../../models/log.dart';
import '../../../resources/database_object_paths/complain_paths.dart';
import '../../../resources/firebase_database_methods.dart';
import '../../../widgets/drop_down_list_from_databse_widget.dart';
import '../../../widgets/text_field_x.dart';
import 'decoration_widget.dart';

class DiffrentialDiagnosisDetailsWidget extends StatefulWidget {
  DiffrentialDiagnosisDetailsWidget(
      {Key? key, required this.complain, required this.complainStatus})
      : super(key: key);
  final Complain complain;
  ComplainStatus complainStatus;
  @override
  State<DiffrentialDiagnosisDetailsWidget> createState() =>
      _DiffrentialDiagnosisDetailsWidgetState();
}
class _DiffrentialDiagnosisDetailsWidgetState
    extends State<DiffrentialDiagnosisDetailsWidget> {
  late List<DifferentialDiagnosis?>? _differentialList;
  TextEditingController dDCommentController = TextEditingController();
  Map<String, dynamic> uploadableMap = {};
  @override
  void dispose() {
    dDCommentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    widget.complain.differentialDiagnosisList != null
        ? _differentialList = widget.complain.differentialDiagnosisList!
        : _differentialList = [];
    // _differentialList.clear();
    // _differentialList..addAll(differentialList());
  }

  @override
  Widget build(BuildContext context) {
    return DecorationWidget(
      title: 'Differential Diagnosis',
      children: [
        if (widget.complain.differentialDiagnosisList != null)
          ReorderableListView.builder(
            itemCount: widget.complain.differentialDiagnosisList!.length,
            itemBuilder: (context, index) {
              return ListTile(
                  key: ValueKey(
                      widget.complain.differentialDiagnosisList![index]!.id!),
                  title: Text(widget
                      .complain.differentialDiagnosisList![index]!.name!));
            },
            shrinkWrap: true,
            onReorder: (int oldIndex, int newIndex) async {
              int index = newIndex;
              if (oldIndex < newIndex) {
                index = newIndex - 1;
              }
              uploadableMap.clear();
              final dd = widget.complain.differentialDiagnosisList!
                  .removeAt(oldIndex);
              widget.complain.differentialDiagnosisList!
                  .insert(index, dd!.copyWith(order: index));
              List<DifferentialDiagnosis?>? tempList =
                  widget.complain.differentialDiagnosisList!;
              tempList = tempList.toSet().toList();

              int i = 0;
              for (var element in tempList) {
                uploadableMap.addAll(updateComplainSubJson(
                    petId: widget.complain.petId!,
                    clientId: widget.complain.clientID!,
                    json: [tempList[i]!.copyWith(order: i).toJson()],
                    id: tempList[i]!.id!,
                    complainId: widget.complain.id!,
                    complainSub: ComplainSub.differentialDiagnosis,
                    complainStatus: ComplainStatus.all));
                i++;
              }
              await FirebaseDatabaseMethods().updateBatch(uploadableMap);
            },
          )
        else
          Container()
      ],
      onAddPressed: () {
        String _value = '';
        String id = const Uuid().v1();
        Get.defaultDialog(
            onConfirm: () {
              DifferentialDiagnosis differentialDiagnosis =
                  DifferentialDiagnosis(
                path: '${widget.complain.path}/differentialDiagnosis/$id',
                id: id,
                name: _value,
                order: 0,
                comment: dDCommentController.text.trim(),
              );
              Log log = Log(
                  dateTime: DateTime.now().microsecondsSinceEpoch,
                  complainId: widget.complain.id!,
                  addedBy: FirebaseAuth.instance.currentUser!.email!,
                  isACall: false,
                  comment: 'A D-Diagnosis Added');
              FirebaseDatabaseMethods().updateBatch(
                  updateComplainSubJson(
                petId: widget.complain.petId!,
                clientId: widget.complain.clientID!,
                json: [differentialDiagnosis.toJson()],
                id: differentialDiagnosis.id!,
                complainId: widget.complain.id!,
                complainSub: ComplainSub.differentialDiagnosis,
                complainStatus: widget.complainStatus,
              )..addAll(updateComplainSubJson(
                  petId: widget.complain.petId!,
                  clientId: widget.complain.clientID!,
                  json: [differentialDiagnosis.toJson()],
                  id: differentialDiagnosis.id!,
                  complainId: widget.complain.id!,
                  complainSub: ComplainSub.differentialDiagnosis,
                  complainStatus: ComplainStatus.all,
                )));
              Get.back();
              dDCommentController.clear();
            },
            title: 'Select Disease',
            content: Column(
              children: [
                DropDownListFromDatabaseWidget(
                    databasePath: '$doctorPath/diseases',
                    databaseVariable: 'name',
                    hintText: 'Select Disease',
                    onSelect: (value) {
                      _value = value!;
                    }),
                TextFieldX(
                  label: 'Comment',
                  controller: dDCommentController,
                )
              ],
            ));
      },
    );
  }
}
