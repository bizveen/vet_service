

import 'package:get/get.dart';

import 'global_live_variables_controller.dart';

class InitialBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<GlobalLiveVariablesController>(()=>GlobalLiveVariablesController());

  }

}