import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/badge/gf_badge.dart';
import 'package:getwidget/shape/gf_badge_shape.dart';
import 'package:uuid/uuid.dart';
import 'package:vet_service/screens/shop_screens/products_showcase_screen.dart';

import '../../constants.dart';
import '../../models/client_model.dart';
import '../../models/sale/Sale.dart';
import '../../resources/database_object_paths/other_paths.dart';
import '../../resources/firebase_database_methods.dart';
import '../../resources/sales_methods.dart';
import '../../utils/tiny_space.dart';
import '../../utils/utils.dart';
import '../add_pet_screen/add_pet_screen.dart';
import 'bill_screen.dart';

class ActiveCasesScreen extends StatefulWidget {
  const ActiveCasesScreen({Key? key}) : super(key: key);

  @override
  State<ActiveCasesScreen> createState() => _ActiveCasesScreenState();
}

class _ActiveCasesScreenState extends State<ActiveCasesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Active Cases Screen"),),
      body:   FirebaseDatabaseQueryBuilder(
          query: FirebaseDatabaseMethods()
              .reference(path: '$doctorPath/sales/all')
              .orderByChild('isActive')
              .equalTo(true),
          builder: (context, snapshot, _) {
            List<Sale> saleList = [];
            dataSnapShotListToMap(children: snapshot.docs)
                .forEach((key, value) {
              Sale sale = Sale.fromJson(value);
              if (!sale.getTotalCharges().isEqual(0)) {
                saleList.add(sale);
              }
            });

            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.8,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Center(
                      child: SizedBox(
                        width: 100,
                        child: Card(
                          elevation: 50
                          ,
                          color: Get.theme.backgroundColor,
                          child: Padding(

                            padding: const EdgeInsets.all(8.0),
                            child: Column(

                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Active'),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: saleList
                                      .map(
                                        (e) => Padding(
                                      padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(BillScreen(sale: e));
                                        },
                                        child: Container(

                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),

                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.white,
                                                  blurRadius: 10.0,
                                                  spreadRadius: 1.0,
                                                  offset: Offset(
                                                    0.0,
                                                    4.0,
                                                  ),
                                                ),
                                              ]),
                                          child: GFBadge(

                                            shape: GFBadgeShape.pills,
                                            size: 80,
                                            child: Text(
                                              e
                                                  .getTotalCharges()
                                                  .toInt()
                                                  .toString(),
                                              style: const TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 50,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                          onPressed: () {
                            FirebaseDatabaseMethods().updateBatch({
                              // 'clients': {},
                              // 'complains': {},
                              // 'vaccinations': {},
                              // 'pets': {},
                              // 'contacts': {},
                              // 'sales': {},
                              'oldDB': {},
                              'test' : {},
                              'clients/updated' :{},
                              'copy' :{},
                              // '$doctorPath/inventoryOut': {},
                              // '$doctorPath/clients': {},
                              // '$doctorPath/complains': {},
                              // '$doctorPath/vaccinations': {},
                              // '$doctorPath/pets': {},
                              // '$doctorPath/sales': {},
                            });
                          },
                          child: Text('Delete all'),
                        ),
                        FloatingActionButton(
                          onPressed: () async {
                            ClientModel client = ClientModel(
                              clientStatus: ClientStatus.fake.index,
                              id: const Uuid().v1(),
                              doctorId: doctorId,
                              isActive: false,
                            );
                            await FirebaseDatabaseMethods().updateBatch(
                                updateClientJson(
                                    clientId: client.id!,
                                    clientStatus: ClientStatus
                                        .values[client.clientStatus!],
                                    json: [client.toJson()]));
                            await SalesMethods(
                                clientId: client.id!,
                                clientStatus: ClientStatus
                                    .values[client.clientStatus!])
                                .createASale();
                            ClientModel updatedClient =
                            await FirebaseDatabaseMethods()
                                .getClientFromID(
                                id: client.id!,
                                clientStatus: ClientStatus.values[
                                client.clientStatus!]);
                            Get.to(ProductShowCaseScreen(
                              clientStatus: ClientStatus
                                  .values[updatedClient.clientStatus!],
                              clientModel: updatedClient,
                            ));
                          },
                          child: Text('Products'),
                        ),
                        TinySpace(),
                        FloatingActionButton(
                          onPressed: () async {
                            ClientModel client = ClientModel(
                              clientStatus: ClientStatus.fake.index,
                              id: const Uuid().v1(),
                              doctorId: doctorId,
                              isActive: false,
                            );
                            await FirebaseDatabaseMethods().updateBatch(
                                updateClientJson(
                                    clientId: client.id!,
                                    clientStatus: ClientStatus
                                        .values[client.clientStatus!],
                                    json: [client.toJson()]));
                            await SalesMethods(
                                clientId: client.id!,
                                clientStatus: ClientStatus
                                    .values[client.clientStatus!])
                                .createASale();
                            ClientModel updatedClient =
                            await FirebaseDatabaseMethods()
                                .getClientFromID(
                                id: client.id!,
                                clientStatus: ClientStatus.values[
                                client.clientStatus!]);
                            Get.to(ProductShowCaseScreen(
                              clientStatus: ClientStatus
                                  .values[updatedClient.clientStatus!],
                              clientModel: updatedClient,
                            ));
                          },
                          child: Text('Products'),
                        ),
                        TinySpace(),
                        FloatingActionButton(
                          onPressed: () async {
                            // Get.to(DataExporter());
                          },
                          child: const Icon(Icons.account_box),
                        ),
                        TinySpace(),
                        isDoctorBinded
                            ? FloatingActionButton(
                          heroTag: 'clntBtn2',
                          onPressed: () async {
                            //await FakeInformation().createDatabase();
                            //await FirebaseDatabaseMethods().blankJson('users/WDBOygTvZlNJw0bxzzly5MIdbhv1/clients/');
                            Get.to(() => AddPetScreen());
                          },
                          child: const Text(
                            '+ Client',
                            textAlign: TextAlign.center,
                          ),
                        )
                            : Container(),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
