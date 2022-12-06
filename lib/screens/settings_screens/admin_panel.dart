
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'drug_settings.dart';
import 'examination_settings.dart';
import 'grn_screen/inventory_in_screen.dart';
import 'product_settings.dart';
import 'vaccine_settings.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
      ),
      body: Column(
        children: [
          TextButton(onPressed: (){
            Get.to(()=>const VaccineSettings());
          }, child: const Text('Vaccine Settings')),
          TextButton(onPressed: (){
            Get.to(()=>const ExaminationSettings());
          }, child: const Text('Examination Settings')),
          TextButton(onPressed: (){
            Get.to(()=>const DrugsSettings());
          }, child: const Text('Drugs Settings')),
          TextButton(onPressed: (){
            Get.to(()=>const ProductsSettings());
          }, child: const Text('Products Settings')),

          TextButton(onPressed: (){
            Get.to(()=>InventoryInScreen());
          }, child: const Text('GRN Screen')),
        ],
      ),
    );
  }
}
