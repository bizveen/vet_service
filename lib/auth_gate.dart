
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vet_service/screens/main_screen/main_screen.dart';

import 'resources/firebase_database_methods.dart';
import 'screens/authentication_screens/sign_in_screen/sign_in_screen.dart';
import 'screens/main_screen/pet_list_screen.dart';
import 'screens/profile_screens/my_profile_screen.dart';

class AuthGate extends StatelessWidget {
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    //  return Builder(builder: (context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Card(
            child: Center(
              child: Column(
                children: const [
                  CircularProgressIndicator(),
                  Text('Loading..'),
                ],
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            if(box.read('doctorId')== null){
            return FutureBuilder(
                future: FirebaseDatabaseMethods().reference(
                    path:
                        'users/${FirebaseAuth.instance.currentUser!.uid}/profile').get(),

                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<dynamic, dynamic> userProfileMap =
                    (snapshot.data as DataSnapshot).value as Map<dynamic, dynamic>;
                    // Get.find<GlobalLiveVariablesController>()
                    //     .currentDoctor
                    //     .value = userProfileMap['doctorId'];
                    // Get.find<GlobalLiveVariablesController>().isAdmin.value =
                    //     userProfileMap['isAdmin'] as bool;
                    box.write('doctorId', userProfileMap['doctorId']);
                    box.write('isAdmin', userProfileMap['isAdmin'] as bool);

                    return userProfileMap['doctorId'] != null
                        ?  MainScreen()
                        : Scaffold(
                            body: Center(
                                child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('Please Contact your veterinary'),
                                TextButton(
                                  onPressed: () {
                                    Get.to(
                                      MyProfileScreen(
                                        path:
                                            'users/${FirebaseAuth.instance.currentUser!.uid}',
                                      ),
                                    );
                                  },
                                  child: const Text('Show My Profile'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    FirebaseAuth.instance.signOut();
                                  },
                                  child: const Text('Sign Out'),
                                ),
                              ],
                            )),
                          );
                  } else {
                    return const Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                });} else{
              return  MainScreen();
            }
          } else {
            return SignInScreenView();
          }
        } else {
          return const Card(
            child: Center(
              child: Text('Error'),
            ),
          );
        }
      },
    );
  }
}
