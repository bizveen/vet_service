
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';
import 'package:vet_service/constants.dart';
import '../../models/client_model.dart';
import '../../models/sale/Invoice.dart';
import '../../resources/firebase_database_methods.dart';
import '../../screens/shop_screens/invoice_screen.dart';
import '../../utils/tiny_space.dart';
import '../../utils/utils.dart';
import 'product_bill_widget.dart';
import 'treatment_bill_widget.dart';
import 'vaccination_bill_widget.dart';

class TotalBillWidgets extends StatefulWidget {
  ClientStatus clientStatus;
  String invoiceId;

   TotalBillWidgets({Key? key , required this.invoiceId,required this.clientStatus}) : super(key: key);

  @override
  State<TotalBillWidgets> createState() => _TotalBillWidgetsState();
}

class _TotalBillWidgetsState extends State<TotalBillWidgets> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      child: FirebaseDatabaseQueryBuilder(
          query: FirebaseDatabaseMethods().reference(path: '$doctorPath/invoices/${widget.invoiceId}'),
          builder: (context , snapshot , _) {
            Invoice invoice = Invoice.fromJson(dataSnapShotListToMap(children: snapshot.docs));
          return InkWell(
            onTap: (){
              Get.to(InvoiceScreen(invoiceId: widget.invoiceId));
            },
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Bill', style: Get.textTheme.headline5,),
                ),
                Card(

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BillLine(value: invoice.getTotalCharges().toStringAsFixed(2)),
                      invoice.inventoryOutList != null ? ProductBillWidget(sale: invoice) : Container(),
                      invoice.vaccineList != null ? VaccinesBillWidget(sale: invoice) : Container(),
                      invoice.treatmentList != null ? TreatmentBillWidget(sale: invoice,) : Container(),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}

class BillLine extends StatelessWidget {
   BillLine({
    Key? key,
    required this.value,
    this.label = "Total",
  }) : super(key: key);

  final String value;
  String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      color : Get.theme.primaryColor,
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              Text(label, style: Get.textTheme.bodySmall!.copyWith(color: Get.theme.colorScheme.onPrimary),),
             TinySpace(),
              Text('Rs.${value}',
                  style: Get.textTheme.headline5!.copyWith(color: Get.theme.colorScheme.onPrimary)),
             TinySpace(),
              Icon(Icons.arrow_circle_right_outlined, color: Get.theme.backgroundColor,),
            ],
          ),
        ),
      ),
    );
  }
}
