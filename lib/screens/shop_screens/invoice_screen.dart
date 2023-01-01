import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:uuid/uuid.dart';
import 'package:vet_service/controllers/client_controller.dart';

import '../../constants.dart';
import '../../models/client_model.dart';
import '../../models/sale/Invoice.dart';
import '../../models/sale/inventory_in.dart';
import '../../resources/database_object_paths/other_paths.dart';
import '../../resources/database_object_paths/sales_paths.dart';
import '../../resources/firebase_database_methods.dart';
import '../../utils/tiny_space.dart';
import '../../utils/utils.dart';
import '../../widgets/container_with_border.dart';
import '../../widgets/text_field_x.dart';
import 'bill_table_row_widget.dart';

class InvoiceScreen extends StatefulWidget {
  String invoiceId;

  InvoiceScreen({Key? key, required this.invoiceId}) : super(key: key);

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
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
              FirebaseDatabaseQueryBuilder(
                  query: FirebaseDatabaseMethods().reference(
                      path: '$doctorPath/invoices/${widget.invoiceId}'),
                  pageSize: 50,
                  builder: (context, snapshot, _) {
                    if (snapshot.isFetching) {
                      return CircularProgressIndicator();
                    }
                    if (snapshot.hasData) {
                      Invoice invoice = Invoice.fromJson(
                          dataSnapShotListToMap(children: snapshot.docs));
                      return ContainerWithBorder(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('To:'),
                              Text(
                                invoice.clientId ??"N/A",
                                style: Get.textTheme.headline6,
                              ),
                              // Text(client.address!),
                              TinySpace(height: 20),
                              Table(
                                  border: const TableBorder(
                                    horizontalInside: BorderSide(
                                        width: 1, color: Colors.grey),
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
                                    ..addAll(invoice.vaccineList != null
                                        ? List.generate(
                                            invoice.vaccineList!.length,
                                            (index) => BillTableRowWidget(
                                                item: invoice
                                                    .vaccineList![index]!.name!,
                                                qty: 1,
                                                price: invoice
                                                    .vaccineList![index]!
                                                    .retailPrice!
                                                    .toDouble()!))
                                        : [])
                                    ..addAll(invoice.treatmentList != null
                                        ? List.generate(
                                            invoice.treatmentList!.length,
                                            (index) => BillTableRowWidget(
                                                item:
                                                    'Treatment > ${invoice.treatmentList![index]!.treatmentTitle ?? 'Special'}',
                                                qty: 1,
                                                price: invoice
                                                    .treatmentList![index]!
                                                    .charges!
                                                    .toDouble()))
                                        : [])
                                    ..addAll(invoice.inventoryOutList != null
                                        ? List.generate(
                                            invoice.inventoryOutList!.length,
                                            (index) => BillTableRowWidget(
                                                item:
                                                    'Treatment > ${invoice.inventoryOutList![index]!.product!.name! ?? 'Special'}',
                                                qty: invoice
                                                    .inventoryOutList![index]!
                                                    .qty!,
                                                price: invoice
                                                    .inventoryOutList![index]!
                                                    .retailPrice!
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('Total : ',
                                        style: Get.textTheme.headline6),
                                    Text(invoice.getTotalCharges().toString(),
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
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text('Cancel')),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: Text("Error"),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
