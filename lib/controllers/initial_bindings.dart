

import 'package:get/get.dart';
import 'package:vet_service/controllers/client_controller.dart';
import 'package:vet_service/screens/add_treatment_screen/add_treatment_screen_controller.dart';

import 'global_live_variables_controller.dart';

class InitialBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<GlobalLiveVariablesController>(()=>GlobalLiveVariablesController());
    Get.put(ClientController());
    Get.put(AddTreatmentScreenController());

  }

}