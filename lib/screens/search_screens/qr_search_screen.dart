
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';

import '../../models/Pet.dart';
import '../../resources/firebase_database_methods.dart';
import '../../widgets/pet_card.dart';

class QrSearchScreen extends StatefulWidget {
  const QrSearchScreen({Key? key}) : super(key: key);

  @override
  State<QrSearchScreen> createState() => _QrSearchScreenState();
}

class _QrSearchScreenState extends State<QrSearchScreen> {
  TextEditingController qrSearchController = TextEditingController();
  late String qrSearch;
  @override
  void initState() {
    qrSearch = qrSearchController.text;
    super.initState();
  }
  @override
  void dispose() {
    qrSearchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(title: const Text('QR Search')),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(child: const Text('Search QR'), onPressed: () async {
            String barcodeScanRes;
            // Platform messages may fail, so we use a try/catch PlatformException.
            try {
              barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                  '#ff6666', 'Cancel', true, ScanMode.QR);

                qrSearch = barcodeScanRes;


            } on PlatformException {
              barcodeScanRes = 'Failed to get platform version.';
            }

            // If the widget was removed from the tree while the asynchronous platform
            // message was in flight, we want to discard the reply rather than calling
            // setState to update our non-existent appearance.
            if (!mounted) {


              return;
            }

setState(() {
  qrSearchController.value  = TextEditingValue(text: qrSearch) ;
});





          },),
          TextFormField(
            controller: qrSearchController,
            onChanged: (value){
              setState(() {
                qrSearch = value;
              });
            },
          ),
          Expanded(
            child: FirebaseDatabaseListView(
                query: FirebaseDatabaseMethods().reference(path: 'pets').orderByChild('qrCode').startAt(qrSearch).endAt('$qrSearch\uf8ff'),
                shrinkWrap: true,
                itemBuilder: (context, snapshot){
    Pet pet = Pet.fromJson(snapshot.value);
    return PetCard(pet: pet);

    }


                ),
          )
        ],
       
      ),
    );
  }
}
