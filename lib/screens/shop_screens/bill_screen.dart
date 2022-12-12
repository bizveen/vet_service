import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:uuid/uuid.dart';
import 'package:vet_service/controllers/client_controller.dart';

import '../../constants.dart';
import '../../models/client_model.dart';
import '../../models/sale/Sale.dart';
import '../../models/sale/inventory_in.dart';
import '../../resources/database_object_paths/other_paths.dart';
import '../../resources/database_object_paths/sales_paths.dart';
import '../../resources/firebase_database_methods.dart';
import '../../utils/tiny_space.dart';
import '../../utils/utils.dart';
import '../../widgets/container_with_border.dart';
import '../../widgets/text_field_x.dart';
import 'bill_table_row_widget.dart';

class BillScreen extends StatefulWidget {
  Sale sale;

  BillScreen({Key? key, required this.sale}) : super(key: key);

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  TextEditingController discountController = TextEditingController();
  TextEditingController paymentController = TextEditingController();
  TextEditingController balanceController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    discountController.dispose();
    paymentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bill Screen'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Invoice',
                overflow: TextOverflow.ellipsis,
                style: Get.theme.textTheme.headline2,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: StreamBuilder<ClientModel>(
                    stream: Get.find<ClientController>()
                        .getClientFromId(widget.sale.clientId!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasData) {
                        ClientModel client = snapshot.data as ClientModel;
                        return ContainerWithBorder(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('To:'),
                                Text(
                                  client.name!,
                                  style: Get.textTheme.headline6,
                                ),
                                Text(client.address!),
                              ],
                            ),
                          ),
                        );
                      }else {
                        return Center(child: Text("Error"),);
                      }
                    }),
              ),
              TinySpace(height: 20),
              Table(
                  border: const TableBorder(
                    horizontalInside: BorderSide(width: 1, color: Colors.grey),
                    bottom: BorderSide(
                      width: 1,
                    ),
                  ),
                  children: [
                    const TableRow(children: [
                      Text('Title'),
                      Text('Qty'),
                      Text('Rate'),
                      Text('Line Total'),
                    ])
                  ]
                    ..addAll(widget.sale.vaccineList != null
                        ? List.generate(
                            widget.sale.vaccineList!.length,
                            (index) => BillTableRowWidget(
                                item: widget.sale.vaccineList![index]!.name!,
                                qty: 1,
                                price: widget
                                    .sale.vaccineList![index]!.retailPrice!
                                    .toDouble()!))
                        : [])
                    ..addAll(widget.sale.treatmentList != null
                        ? List.generate(
                            widget.sale.treatmentList!.length,
                            (index) => BillTableRowWidget(
                                item:
                                    'Treatment > ${widget.sale.treatmentList![index]!.treatmentTitle ?? 'Special'}',
                                qty: 1,
                                price: widget
                                    .sale.treatmentList![index]!.charges!
                                    .toDouble()))
                        : [])
                    ..addAll(widget.sale.inventoryOutList != null
                        ? List.generate(
                            widget.sale.inventoryOutList!.length,
                            (index) => BillTableRowWidget(
                                item:
                                    'Treatment > ${widget.sale.inventoryOutList![index]!.product!.name! ?? 'Special'}',
                                qty: widget.sale.inventoryOutList![index]!.qty!,
                                price: widget
                                    .sale.inventoryOutList![index]!.retailPrice!
                                    .toDouble()))
                        : [])
                  // ..addAll(
                  //   widget.sale.inventoryOutList != null
                  //       ? List.generate(
                  //           widget.sale.inventoryOutList!.length,
                  //           (index) => TableRow(
                  //                 children: [
                  //                   Text(widget
                  //                       .sale
                  //                       .inventoryOutList![index]!
                  //                       .product!
                  //                       .name!),
                  //                   // Text(widget.sale.productList![index]!.qty!),
                  //                   Text(widget
                  //                       .sale
                  //                       .inventoryOutList![index]!
                  //                       .retailPrice!
                  //                       .toString()),
                  //                 ],
                  //               ))
                  //       : [],
                  // ),
                  ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Total : ', style: Get.textTheme.headline6),
                    Text(widget.sale.getTotalCharges().toString(),
                        style: Get.textTheme.headline6),
                  ],
                ),
              ),
              TextFieldX(
                label: 'Discounts',
                controller: discountController,
              ),
              TextFieldX(
                label: 'Payment',
                controller: paymentController,
              ),
              TextFieldX(
                label: 'Balance',
                controller: balanceController,
              ),
              ElevatedButton(
                  onPressed: () async {
                    Sale sale = widget.sale.copyWith(
                      balance: balanceController.text.trim().toDouble(),
                      payment: paymentController.text.trim().toDouble(),
                      discount: discountController.text.trim().toDouble(),
                      isActive: false,
                      closedBy: FirebaseAuth.instance.currentUser!.email!,
                    );
                    await FirebaseDatabaseMethods().updateBatch(updateSalesJson(
                        billingStatus: BillingStatus.bill,
                        clientStatus:
                            ClientStatus.values[widget.sale.clientStatus!],
                        clientId: widget.sale.clientId,
                        salesId: widget.sale.id!,
                        json: [sale.toJson()])
                      ..addAll(updateClientJson(
                          clientId: widget.sale.clientId!,
                          clientStatus:
                              ClientStatus.values[widget.sale.clientStatus!],
                          variables: ['isActive', 'currentActiveCaseId'],
                          json: [false, null])));
                    Get.back();
                  },
                  child: const Text('Save')),
              ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Cancel')),
            ],
          ),
        ),
      ),
    );
  }
}
