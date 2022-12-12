
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/badge/gf_badge.dart';
import 'package:getwidget/shape/gf_badge_shape.dart';
import 'package:uuid/uuid.dart';
import 'package:vet_service/screens/main_screen/vaccination_list_screen/vaccination_list_screen.dart';
import 'package:vet_service/screens/shop_screens/active_cases_screen.dart';

import '../../constants.dart';
import '../../models/client_model.dart';
import '../../models/sale/Sale.dart';
import '../../resources/database_object_paths/other_paths.dart';
import '../../resources/firebase_database_methods.dart';
import '../../resources/sales_methods.dart';
import '../../utils/tiny_space.dart';
import '../../utils/utils.dart';
import '../add_pet_screen/add_pet_screen.dart';
import '../shop_screens/bill_screen.dart';
import '../shop_screens/products_showcase_screen.dart';
import 'complains_list_screen/complains_list_screen.dart';
import 'pet_list_screen.dart';


class MainScreen extends StatefulWidget  {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController pageController = PageController( initialPage: 1);

  int pageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: DefaultTabController(
        length:4 ,
        child: Scaffold(
          body:// DataExporter()
             PageView(

                physics: NeverScrollableScrollPhysics(),
                controller: pageController,

                children: const [
                  ActiveCasesScreen(),
                  PetListScreen(),
                  //  ClientListScreen(),
                  ComplainsListScreen(),
                  VaccinationsListScreen(),

                  //ActiveCasesScreen(),
                  // ComplainFollowupScreen(),
                  //VaccinationRemindersScreen()
                ]),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 1, color: Colors.grey[400]!))),
              child: TabBar(
                onTap: (val){
                  setState((){
                    pageController.jumpToPage(val);
                  });
                },
                indicator: BoxDecoration(
                    //color: activeCyanColor.withOpacity(0.05),
                    border: Border(
                        top: BorderSide(
                            color: Theme.of(context).primaryColor, width: 6))),
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Tab(
                      icon: Icon(
                    Icons.home_outlined,
                    color: pageIndex == 0
                        ? Theme.of(context).primaryColor
                        : Colors.black,
                  )),

                  Tab(
                    icon: Icon(
                      Icons.directions_run,
                      color: pageIndex == 1
                          ? Theme.of(context).primaryColor
                          : Colors.black,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.vaccines_outlined,
                      color: pageIndex == 2
                          ? Theme.of(context).primaryColor
                          : Colors.black,
                    ),
                  ),

                  Tab(
                    icon: Icon(
                      Icons.vaccines_outlined,
                      color: pageIndex == 3
                          ? Theme.of(context).primaryColor
                          : Colors.black,
                    ),
                  ),
                  // Tab(
                  //     icon: Icon(Icons.account_circle_outlined,
                  //         color: pageIndex == 2 ? Theme.of(context).primaryColor : Colors.black)),
                  // Tab(
                  //     icon: Icon(FontAwesome5.hands,
                  //         color: pageIndex == 3 ? Theme.of(context).primaryColor : Colors.black)),
                  // Tab(
                  //     icon: Icon(RpgAwesome.ringing_bell,
                  //         color: pageIndex == 4 ? Theme.of(context).primaryColor : Colors.black)),
                ],
              ),
            ),


        ),
      ),
    );
  }
}
