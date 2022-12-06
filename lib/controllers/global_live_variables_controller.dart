import 'package:get/get.dart';

class GlobalLiveVariablesController extends GetxController{

  final currentDoctor = ''.obs;

 final isAdmin =RxnBool(false);

bool getIsAdmin(){
  return isAdmin.value ?? false;
}

bool isDoctorBinded(){
  return currentDoctor.value!='';
}


}