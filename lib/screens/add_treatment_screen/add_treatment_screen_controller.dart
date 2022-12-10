import 'package:get/get.dart';
import 'package:vet_service/models/complain/Drug.dart';

class AddTreatmentScreenController extends GetxController {

  RxList<Drug> selectedDrugsList = RxList<Drug>();

  @override
  void dispose() {

    super.dispose();
  //  chargesController.dispose();
  }
}