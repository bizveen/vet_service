
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getwidget/getwidget.dart';
import 'package:uuid/uuid.dart';

import '../../constants.dart';
import '../../models/client_model.dart';
import '../../models/sale/Invoice.dart';
import '../../resources/database_object_paths/other_paths.dart';
import '../../resources/firebase_database_methods.dart';
import '../../resources/sales_methods.dart';
import '../../utils/tiny_space.dart';
import '../../utils/utils.dart';
import '../add_pet_screen/add_pet_screen.dart';
import '../shop_screens/invoice_screen.dart';
import '../shop_screens/products_showcase_screen.dart';
import 'client_search_screen.dart';
import 'contact_search_screen.dart';
import 'pet_search_screen.dart';


class MainSearchScreen extends StatefulWidget {
  const MainSearchScreen({Key? key}) : super(key: key);

  @override
  State<MainSearchScreen> createState() => _MainSearchScreenState();
}

class _MainSearchScreenState extends State<MainSearchScreen> {
  PageController pageController = PageController();
  int pageIndex = 0;

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(

        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Search Screen'),
            bottom: TabBar(
              onTap: changePage,
              indicator: BoxDecoration(
                //color: activeCyanColor.withOpacity(0.05),
                  border: Border(
                      top: BorderSide(
                          color: Theme.of(context).primaryColor, width: 6))),
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [


                Tab(
                  icon: Icon(
                    Icons.phone_android,
                    color: pageIndex == 0
                        ? Theme.of(context).backgroundColor
                        : Colors.black,
                  ),
                  text: 'by Contact No',
                ),
                Tab(
                  icon: Icon(
                    Icons.person,
                    color: pageIndex == 1
                        ? Theme.of(context).backgroundColor
                        : Colors.black,
                  ),
                  text: 'by Client',
                ),
                Tab(
                  icon: Icon(
                    Icons.pets,
                    color: pageIndex == 2
                        ? Theme.of(context).backgroundColor
                        : Colors.black,
                  ),
                  text: 'by Pet',
                ),

              ],
            ),
          ),
            body: PageView(
                controller: pageController, children: const [

            //  ClientListScreen(),
              ClientSearchScreen(),
              PetSearchScreen()

              //ActiveCasesScreen(),
              // ComplainFollowupScreen(),
              //VaccinationRemindersScreen()
            ]),

            floatingActionButton: Align(
              alignment: Alignment.topRight,
              child: FirebaseDatabaseQueryBuilder(
                  query: FirebaseDatabaseMethods()
                      .reference(path: 'sales')
                      .orderByChild('isActive')
                      .equalTo(true),
                  builder: (context, snapshot, _) {
                    List<Invoice> saleList = [];
                    dataSnapShotListToMap(children: snapshot.docs)
                        .forEach((key, value) {
                      Invoice sale = Invoice.fromJson(value);
                      if (!sale.getTotalCharges().isEqual(0)) {
                        saleList.add(sale);
                      }
                    });

                    return Stack(
                      children: [
                        Positioned(
                          right: 0,
                          bottom: 120,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: saleList
                                .map(
                                  (e) => Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 2),
                                    child: InkWell(
                                      onTap: (){
                                        Get.to(InvoiceScreen(invoiceId: e.id!));
                                      },
                                      child: GFBadge(

                                        shape: GFBadgeShape.pills,
                                        size: 80,
                                        child: Text(
                                          e.getTotalCharges().toInt().toString(),
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        Positioned(
                          bottom: 50,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

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
                                         clientStatus:ClientStatus.values[client.clientStatus!],
                                          json: [client.toJson()]));
                                  await SalesMethods(clientId: client.id! , clientStatus: ClientStatus.values[client.clientStatus!])
                                      .createASale();
                                  ClientModel updatedClient =
                                      await FirebaseDatabaseMethods()
                                          .getClientFromID(id : client.id!, clientStatus: ClientStatus.values[client.clientStatus!] );
                                  Get.to(ProductShowCaseScreen(
                                    clientStatus: ClientStatus.values[updatedClient.clientStatus!],
                                    clientModel: updatedClient,
                                  ));
                                },
                                child: Text('Products'),
                              ),
                              TinySpace(),
                              FloatingActionButton(
                                onPressed: () async {
                                  String code = '';
                                  String barcodeScanRes;
                                  // Platform messages may fail, so we use a try/catch PlatformException.
                                  try {
                                    barcodeScanRes =
                                        await FlutterBarcodeScanner.scanBarcode(
                                            '#ff6666',
                                            'Cancel',
                                            true,
                                            ScanMode.QR);
                                    setState(() {
                                      code = barcodeScanRes;
                                    });
                                    //Get.to(BarcodeSearchScreen(barcode: code));
                                  } on PlatformException {
                                    barcodeScanRes =
                                        'Failed to get platform version.';
                                  }

                                  // If the widget was removed from the tree while the asynchronous platform
                                  // message was in flight, we want to discard the reply rather than calling
                                  // setState to update our non-existent appearance.
                                  if (!mounted) {
                                    return;
                                  }

                                  // setState(() {
                                  //   _scanBarcode = barcodeScanRes;
                                  // });
                                },
                                child: const Icon(Icons.qr_code),
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
                    );
                  }),
            )),
      ),
    );
  }

  void changePage(int page) {
    pageController.jumpToPage(page);
    setState(() {
      pageIndex = page;
    });
  }
}
