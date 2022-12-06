
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../constants.dart';
import '../../models/client_model.dart';
import '../../models/sale/Sale.dart';
import '../../models/sale/inventory_in.dart';
import '../../models/sale/inventory_out.dart';
import '../../resources/database_object_paths/other_paths.dart';
import '../../resources/database_object_paths/sales_paths.dart';
import '../../resources/firebase_database_methods.dart';
import '../../widgets/bill_widgets/total_bill_widget.dart';
import '../../widgets/product_widgets/product_card.dart';

class ProductShowCaseScreen extends StatefulWidget {
  ClientStatus clientStatus;
  ClientModel? clientModel;

  ProductShowCaseScreen({
    Key? key,
    this.clientModel,
    required this.clientStatus,
  }) : super(key: key);

  @override
  State<ProductShowCaseScreen> createState() => _ProductShowCaseScreenState();
}

class _ProductShowCaseScreenState extends State<ProductShowCaseScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    BackButtonInterceptor.add(myInterceptor);
    // SalesMethods(clientId:widget.clientModel!.id).createASale();
    super.initState();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  Future<bool> myInterceptor(
      bool stopDefaultButtonEvent, RouteInfo info) async {
    Sale sale = await FirebaseDatabaseMethods()
        .getSaleFromID(widget.clientModel!.currentActiveCaseId!);

    if (sale.getTotalCharges().isEqual(0)) {
      await FirebaseDatabaseMethods().updateBatch(
          (updateClientJson(
            clientStatus: ClientStatus.values[sale.clientStatus!],
          clientId: sale.clientId!
          , json: [{}])
            ..addAll(
                updateSalesJson(
                  clientStatus: widget.clientStatus,
                    salesId: sale.id!, json: [{}]))));
    }
    Get.back();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> selectedMap = {};
    TabController tabController = TabController(length: 1, vsync: this);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products Showcase'),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: SizedBox(
                  height: Get.height / 2.5,
                  child: FirebaseDatabaseQueryBuilder(
                      query: FirebaseDatabaseMethods()
                          .reference(path: '$doctorPath/inventoryIn'),
                      builder: (context, snapshot, _) {
                        List<InventoryIn> inventoryIn = [];
                        for (var element in snapshot.docs) {
                          inventoryIn.add(InventoryIn.fromJson(
                              element.value as Map<dynamic, dynamic>));
                        }

                        return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 120,
                              childAspectRatio: 1,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                            ),
                            itemCount: inventoryIn.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return ProductCard(
                                inventoryIn: inventoryIn[index],
                                selectedQty: (selectedQty) async {
                                  InventoryOut out = InventoryOut(
                                    dateTime:
                                        DateTime.now().microsecondsSinceEpoch,
                                    id: widget.clientModel != null
                                        ? widget
                                            .clientModel!.currentActiveCaseId
                                        : Uuid().v1(),
                                    product: inventoryIn[index].product,
                                    qty: selectedQty,
                                    retailPrice: inventoryIn[index].retailPrice,
                                  );
                                  await FirebaseDatabaseMethods().updateBatch(
                                      updateInventoryOuts(
                                         clientStatus: widget.clientStatus,
                                          inventoryInId: inventoryIn[index].id!,
                                          currentActiveCaseId: out.id!,
                                          clientId: widget.clientModel != null
                                              ? widget.clientModel!.id!
                                              : null,
                                          inventoryOut: out));
                                },
                                currentActiveCaseId: widget.clientModel != null
                                    ? widget.clientModel!.currentActiveCaseId!
                                    : const Uuid().v1(),
                              );
                            });
                      }),
                ),
              ),
              const Spacer(),
              widget.clientModel!.currentActiveCaseId != null
                  ? SingleChildScrollView(
                      child: SizedBox(
                          height: Get.height / 2.5,
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: TotalBillWidgets(
                                clientStatus: widget.clientStatus,
                                saleId:
                                    widget.clientModel!.currentActiveCaseId!,
                              ))))
                  : Container()
            ],
          ),
        ],
      ),
    );
  }
}
