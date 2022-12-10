
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';
import '../../models/client_model.dart';
import '../../models/sale/Sale.dart';
import '../../resources/firebase_database_methods.dart';
import '../../screens/shop_screens/bill_screen.dart';
import '../../utils/tiny_space.dart';
import '../../utils/utils.dart';
import 'product_bill_widget.dart';
import 'treatment_bill_widget.dart';
import 'vaccination_bill_widget.dart';

class TotalBillWidgets extends StatefulWidget {
  ClientStatus clientStatus;
  String saleId;

   TotalBillWidgets({Key? key , required this.saleId,required this.clientStatus}) : super(key: key);

  @override
  State<TotalBillWidgets> createState() => _TotalBillWidgetsState();
}

class _TotalBillWidgetsState extends State<TotalBillWidgets> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      child: FirebaseDatabaseQueryBuilder(
          query: FirebaseDatabaseMethods().reference(path: 'sales/${widget.saleId}'),
          builder: (context , snapshot , _) {
            Sale sale = Sale.fromJson(dataSnapShotListToMap(children: snapshot.docs));
          return InkWell(
            onTap: (){
              Get.to(BillScreen(sale: sale));
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
                      BillLine(value: sale.getTotalCharges().toStringAsFixed(2)),
                      sale.inventoryOutList != null ? ProductBillWidget(sale: sale) : Container(),
                      sale.vaccineList != null ? VaccinesBillWidget(sale: sale) : Container(),
                      sale.treatmentList != null ? TreatmentBillWidget(sale: sale,) : Container(),
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
