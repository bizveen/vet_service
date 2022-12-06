
import 'package:flutter/material.dart';

import '../client_list_screen.dart';
import 'called_vaccinations_list_screen.dart';
import 'dismissed_vaccinations_list_screen.dart';
import 'not_called_vaccinations_list_screen.dart';

class VaccinationsListScreen extends StatefulWidget {
  const VaccinationsListScreen({Key? key}) : super(key: key);

  @override
  State<VaccinationsListScreen> createState() => _VaccinationsListScreenState();
}

class _VaccinationsListScreenState extends State<VaccinationsListScreen> {
  PageController pageController = PageController();
  int pageIndex = 0;

  @override
  void dispose() {

    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: PageView(

            controller: pageController,
            children:  const [
              NotCalledVaccinationsListScreen(),
              CalledVaccinationsListScreen(),
              DismissedVaccinationsListScreen(),


              //ActiveCasesScreen(),
             // ComplainFollowupScreen(),
              //VaccinationRemindersScreen()
            ]
        ),
        bottomNavigationBar: Container(
          decoration:  BoxDecoration(
              border: Border(
                  top: BorderSide(
                      width: 1,
                      color: Colors.grey[400]!
                  )
              )
          ),
          child: TabBar(

            onTap: changePage,
            indicator:  BoxDecoration(
              //color: activeCyanColor.withOpacity(0.05),
                border: Border(
                    top: BorderSide(color: Theme.of(context).primaryColor , width: 6)
                )
            ),
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(
                  icon: Icon(
                    Icons.home_outlined,
                    color: pageIndex == 0 ? Theme.of(context).primaryColor : Colors.black,
                  )),
              Tab(
                  icon: Icon(
                    Icons.ac_unit,
                    color: pageIndex == 1 ? Theme.of(context).primaryColor : Colors.black,
                  ),

              ),

              Tab(
                icon: Icon(
                  Icons.vaccines_outlined,
                  color: pageIndex == 2 ? Theme.of(context).primaryColor : Colors.black,
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
    );
  }

  void changePage(int page) {

    pageController.jumpToPage(page);
    setState(() {
      pageIndex = page;
    });

  }
}
