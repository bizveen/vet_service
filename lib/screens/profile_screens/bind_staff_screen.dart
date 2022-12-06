
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

import '../../resources/firebase_database_methods.dart';

class BindStaffScreen extends StatefulWidget {
  //Function(String) onDetect;

  const BindStaffScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BindStaffScreen> createState() => _BindStaffScreenState();
}

class _BindStaffScreenState extends State<BindStaffScreen> {
  String? code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
              onPressed: () async {
                String barcodeScanRes;
                // Platform messages may fail, so we use a try/catch PlatformException.
                try {
                  barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                      '#ff6666', 'Cancel', true, ScanMode.QR);
                  setState(() {
                    code = barcodeScanRes;
                  });
                  //widget.onDetect(barcodeScanRes);
                  await FirebaseDatabaseMethods().updateBatch({
                    'users/$code/doctorId':
                   ' ${FirebaseAuth.instance.currentUser!.uid}'
                  });
                  Get.back();
                } on PlatformException {
                  barcodeScanRes = 'Failed to get platform version.';
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
              child: const Text('Scan QR')),

        ],
      ),
    ));
  }
}
