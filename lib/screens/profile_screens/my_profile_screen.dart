
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../widgets/value_from_database_widget.dart';

class MyProfileScreen extends StatefulWidget {
  String path;
  MyProfileScreen({Key? key , required this.path}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile Screen')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              QrImage(
                data: FirebaseAuth.instance.currentUser!.uid,
                version: QrVersions.auto,
                size: 100.0,
              ),
              ValueFromDatabaseWidget(
                path: widget.path,
                value: 'myName',
                fontSize: 25,
                textColor: Colors.blue,
                label: 'My Name',
              ),
              ValueFromDatabaseWidget(
                  path: widget.path,
                  value: 'address',
                  prefixText: 'My Name',
                  label: 'Address'),
              ValueFromDatabaseWidget(
                  path: widget.path,
                  value: 'role',
                  label: 'Role'),
              ValueFromDatabaseWidget(
                  path:widget.path,
                  value: 'isVerified',
                  label: 'Is Verified?'),
              ValueFromDatabaseWidget(
                  path: widget.path,
                  value: 'gender',
                  label: 'Gender'),
            ],
          ),
        ),
      ),
    );
  }
}
