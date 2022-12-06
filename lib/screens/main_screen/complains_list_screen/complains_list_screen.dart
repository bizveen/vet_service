
import 'package:flutter/material.dart';

import 'active_complain_list_screen.dart';
import 'completed_complain_list_screen.dart';
import 'dismissed_complain_list_screen.dart';


class ComplainsListScreen extends StatefulWidget {
  const ComplainsListScreen({Key? key}) : super(key: key);

  @override
  State<ComplainsListScreen> createState() => _ComplainsListScreenState();
}

class _ComplainsListScreenState extends State<ComplainsListScreen> {
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
ActiveComplainListScreen(),
              CompletedComplainListScreen(),
              DismissedComplainListScreen()

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
