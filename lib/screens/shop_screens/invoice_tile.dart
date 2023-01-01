import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_service/screens/view_details_screens/view_client_details_screen/view_client_details_screen.dart';

import '../../models/sale/Invoice.dart';
import '../../utils/utils.dart';

class InvoiceTile extends StatelessWidget {
  final Invoice sale;

  InvoiceTile({required this.sale});

  @override
  Widget build(BuildContext context) {



    return ListTile(
      title: Text(sale.price.toString()),
      trailing: IconButton(icon: Icon(Icons.arrow_forward),
        onPressed: () { Get.to(ViewClientDetailsScreen(clientId: sale.clientId!));  },),
    );
  }
}
