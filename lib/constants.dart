
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'controllers/global_live_variables_controller.dart';

String examinationCategoriesPath =
    'users/${Get.find<GlobalLiveVariablesController>().currentDoctor.value}/examinationSigns';
String doctorPath =
    'users/$doctorId';
String doctorId = GetStorage().read('doctorId');
bool isDoctorBinded =
    Get.find<GlobalLiveVariablesController>().isDoctorBinded();
bool isAdmin =
GetStorage().read('isAdmin');
Map<String, dynamic> pathListToUpdatableMap(
    {required String id,
    List<String?>? pathList,
    List<String?>? variables,
    required List<dynamic> updatingValue}) {
  Map<String, dynamic> map = {};
  for (var element in pathList!) {
    if (variables == null) {
      map["$element/$id"] = updatingValue[0];
    } else {
      for (int i = 0; i < variables.length; i++) {
        map["$element/$id/${variables[i]}"] = updatingValue[i];
      }
    }
  }

  return map;
}

//modelPaths


// complain related paths
