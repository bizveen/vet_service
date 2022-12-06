
import 'package:flutter/material.dart';

import 'pet_list_screen.dart';


class MainScreen extends StatelessWidget  {
  PageController pageController = PageController( initialPage: 1);
  int pageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          body:// DataExporter()
          PetListScreen(),
            // body: PageView(
            //
            //     physics: NeverScrollableScrollPhysics(),
            //     controller: pageController,
            //     children: const [
            //       PetListScreen(),
            //       //  ClientListScreen(),
            //       ComplainsListScreen(),
            //       VaccinationsListScreen(),
            //
            //       //ActiveCasesScreen(),
            //       // ComplainFollowupScreen(),
            //       //VaccinationRemindersScreen()
            //     ]),
            // bottomNavigationBar: Container(
            //   decoration: BoxDecoration(
            //       border: Border(
            //           top: BorderSide(width: 1, color: Colors.grey[400]!))),
            //   child: TabBar(
            //     onTap: changePage,
            //     indicator: BoxDecoration(
            //         //color: activeCyanColor.withOpacity(0.05),
            //         border: Border(
            //             top: BorderSide(
            //                 color: Theme.of(context).primaryColor, width: 6))),
            //     indicatorSize: TabBarIndicatorSize.label,
            //     tabs: [
            //       Tab(
            //           icon: Icon(
            //         Icons.home_outlined,
            //         color: pageIndex == 0
            //             ? Theme.of(context).primaryColor
            //             : Colors.black,
            //       )),
            //
            //       Tab(
            //         icon: Icon(
            //           Icons.directions_run,
            //           color: pageIndex == 1
            //               ? Theme.of(context).primaryColor
            //               : Colors.black,
            //         ),
            //       ),
            //       Tab(
            //         icon: Icon(
            //           Icons.vaccines_outlined,
            //           color: pageIndex == 2
            //               ? Theme.of(context).primaryColor
            //               : Colors.black,
            //         ),
            //       ),
            //       // Tab(
            //       //     icon: Icon(Icons.account_circle_outlined,
            //       //         color: pageIndex == 2 ? Theme.of(context).primaryColor : Colors.black)),
            //       // Tab(
            //       //     icon: Icon(FontAwesome5.hands,
            //       //         color: pageIndex == 3 ? Theme.of(context).primaryColor : Colors.black)),
            //       // Tab(
            //       //     icon: Icon(RpgAwesome.ringing_bell,
            //       //         color: pageIndex == 4 ? Theme.of(context).primaryColor : Colors.black)),
            //     ],
            //   ),
            // ),
            // floatingActionButton: FirebaseDatabaseQueryBuilder(
            //     query: FirebaseDatabaseMethods()
            //         .reference(path: 'sales')
            //         .orderByChild('isActive')
            //         .equalTo(true),
            //     builder: (context, snapshot, _) {
            //       List<Sale> saleList = [];
            //       dataSnapShotListToMap(children: snapshot.docs)
            //           .forEach((key, value) {
            //         Sale sale = Sale.fromJson(value);
            //         if (!sale.getTotalCharges().isEqual(0)) {
            //           saleList.add(sale);
            //         }
            //       });
            //
            //       return Container(
            //         width: MediaQuery.of(context).size.width,
            //         height: MediaQuery.of(context).size.height*0.8,
            //         child: Stack(
            //           children: [
            //             DraggableWidget(
            //              normalShadow: BoxShadow(color: Colors.transparent),
            //               bottomMargin: 300,
            //               topMargin:0,
            //               intialVisibility: true,
            //               horizontalSpace: 10,
            //               shadowBorderRadius: 5,
            //               verticalSpace: 10,
            //
            //
            //               child: Container(
            //                 margin: EdgeInsets.only(left: 20),
            //                 child: Center(
            //                   child: SizedBox(
            //                     width: 100,
            //                     child: Card(
            //                       elevation: 50
            //                       ,
            //                       color: Get.theme.backgroundColor,
            //                       child: Padding(
            //
            //                         padding: const EdgeInsets.all(8.0),
            //                         child: Column(
            //
            //                           mainAxisSize: MainAxisSize.min,
            //                           children: [
            //                             Text('Active'),
            //                             Column(
            //                               mainAxisSize: MainAxisSize.min,
            //                               children: saleList
            //                                   .map(
            //                                     (e) => Padding(
            //                                       padding:
            //                                           const EdgeInsets.symmetric(vertical: 2),
            //                                       child: InkWell(
            //                                         onTap: () {
            //                                           Get.to(BillScreen(sale: e));
            //                                         },
            //                                         child: Container(
            //
            //                                           decoration: BoxDecoration(
            //                                               borderRadius: BorderRadius.circular(50),
            //
            //                                               boxShadow: const [
            //                                                 BoxShadow(
            //                                                   color: Colors.white,
            //                                                   blurRadius: 10.0,
            //                                                   spreadRadius: 1.0,
            //                                                   offset: Offset(
            //                                                     0.0,
            //                                                     4.0,
            //                                                   ),
            //                                                 ),
            //                                               ]),
            //                                           child: GFBadge(
            //
            //                                             shape: GFBadgeShape.pills,
            //                                             size: 80,
            //                                             child: Text(
            //                                               e
            //                                                   .getTotalCharges()
            //                                                   .toInt()
            //                                                   .toString(),
            //                                               style: const TextStyle(fontSize: 14),
            //                                             ),
            //                                           ),
            //                                         ),
            //                                       ),
            //                                     ),
            //                                   )
            //                                   .toList(),
            //                             ),
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //             Positioned(
            //               bottom: 50,
            //               right: 0,
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.end,
            //                 children: [
            //                   FloatingActionButton(
            //                     onPressed: () {
            //                       FirebaseDatabaseMethods().updateBatch({
            //                         // 'clients': {},
            //                         // 'complains': {},
            //                         // 'vaccinations': {},
            //                         // 'pets': {},
            //                         // 'contacts': {},
            //                         // 'sales': {},
            //                         'oldDB': {},
            //                         'test' : {},
            //                         'clients/updated' :{},
            //                         'copy' :{},
            //                         // '$doctorPath/inventoryOut': {},
            //                         // '$doctorPath/clients': {},
            //                         // '$doctorPath/complains': {},
            //                         // '$doctorPath/vaccinations': {},
            //                         // '$doctorPath/pets': {},
            //                         // '$doctorPath/sales': {},
            //                       });
            //                     },
            //                     child: Text('Delete all'),
            //                   ),
            //                   FloatingActionButton(
            //                     onPressed: () async {
            //                       ClientModel client = ClientModel(
            //                         clientStatus: ClientStatus.fake.index,
            //                         id: const Uuid().v1(),
            //                         doctorId: doctorId,
            //                         isActive: false,
            //                       );
            //                       await FirebaseDatabaseMethods().updateBatch(
            //                           updateClientJson(
            //                               clientId: client.id!,
            //                               clientStatus: ClientStatus
            //                                   .values[client.clientStatus!],
            //                               json: [client.toJson()]));
            //                       await SalesMethods(
            //                               clientId: client.id!,
            //                               clientStatus: ClientStatus
            //                                   .values[client.clientStatus!])
            //                           .createASale();
            //                       ClientModel updatedClient =
            //                           await FirebaseDatabaseMethods()
            //                               .getClientFromID(
            //                                   id: client.id!,
            //                                   clientStatus: ClientStatus.values[
            //                                       client.clientStatus!]);
            //                       Get.to(ProductShowCaseScreen(
            //                         clientStatus: ClientStatus
            //                             .values[updatedClient.clientStatus!],
            //                         clientModel: updatedClient,
            //                       ));
            //                     },
            //                     child: Text('Products'),
            //                   ),
            //                   TinySpace(),
            //                   FloatingActionButton(
            //                     onPressed: () async {
            //                       ClientModel client = ClientModel(
            //                         clientStatus: ClientStatus.fake.index,
            //                         id: const Uuid().v1(),
            //                         doctorId: doctorId,
            //                         isActive: false,
            //                       );
            //                       await FirebaseDatabaseMethods().updateBatch(
            //                           updateClientJson(
            //                               clientId: client.id!,
            //                               clientStatus: ClientStatus
            //                                   .values[client.clientStatus!],
            //                               json: [client.toJson()]));
            //                       await SalesMethods(
            //                           clientId: client.id!,
            //                           clientStatus: ClientStatus
            //                               .values[client.clientStatus!])
            //                           .createASale();
            //                       ClientModel updatedClient =
            //                       await FirebaseDatabaseMethods()
            //                           .getClientFromID(
            //                           id: client.id!,
            //                           clientStatus: ClientStatus.values[
            //                           client.clientStatus!]);
            //                       Get.to(ProductShowCaseScreen(
            //                         clientStatus: ClientStatus
            //                             .values[updatedClient.clientStatus!],
            //                         clientModel: updatedClient,
            //                       ));
            //                     },
            //                     child: Text('Products'),
            //                   ),
            //                   TinySpace(),
            //                   FloatingActionButton(
            //                     onPressed: () async {
            //                       Get.to(DataExporter());
            //                     },
            //                     child: const Icon(Icons.account_box),
            //                   ),
            //                   TinySpace(),
            //                   isDoctorBinded
            //                       ? FloatingActionButton(
            //                           heroTag: 'clntBtn2',
            //                           onPressed: () async {
            //                             //await FakeInformation().createDatabase();
            //                             //await FirebaseDatabaseMethods().blankJson('users/WDBOygTvZlNJw0bxzzly5MIdbhv1/clients/');
            //                             Get.to(() => AddPetScreen());
            //                           },
            //                           child: const Text(
            //                             '+ Client',
            //                             textAlign: TextAlign.center,
            //                           ),
            //                         )
            //                       : Container(),
            //                 ],
            //               ),
            //             )
            //           ],
            //         ),
            //       );
            //     }),
        ),
      ),
    );
  }

}
