
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/global_live_variables_controller.dart';
import '../../resources/firebase_firestore_methods.dart';
import '../accounting_screens/my_daily_sales_screen.dart';
import '../complain_screens/local_widgets/first_inspection_widget.dart';
import '../profile_screens/bind_staff_screen.dart';
import '../profile_screens/my_profile_screen.dart';
import '../settings_screens/admin_panel.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool uploadingCallLogs = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Get.find<GlobalLiveVariablesController>().getIsAdmin()
                ? Column(
                  children: [
                    ElevatedButton(

                        onPressed: () {
                          Get.to(const BindStaffScreen());
                        },
                        child: const Text('Bind a Staff Member'),
                      ),
                    ElevatedButton(
                        onPressed: () {
                          Get.to(const AdminPanel());
                        },
                        child: const Text('Admin Panel')),
                    ElevatedButton(
                        onPressed: () {
                          Get.to(const FirstInspectionWidget());
                        },
                        child: const Text('Test Button'))
                  ],
                )
                : Container(),
            TextButton(
                onPressed: () {
                   Get.to( MyProfileScreen( path: 'users/${FirebaseAuth.instance.currentUser!.uid}'));
                },
                child: const Text('My Profile')),

            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    uploadingCallLogs = true;
                  });
                  await FirebaseFirestoreMethods().updateCallLogs();
                  setState(() {
                    uploadingCallLogs = false;
                  });
                },
                child: uploadingCallLogs
                    ? const CircularProgressIndicator()
                    : const Text('Sync call Logs')),
            ElevatedButton(onPressed: (){
              Get.to(MyDailySalesScreen());
            }, child: Text('My Daily Sales')),
            Spacer(),
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}
