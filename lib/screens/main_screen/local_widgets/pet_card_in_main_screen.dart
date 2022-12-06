import 'dart:ffi';


import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

import 'package:get/get.dart';
import 'package:vet_service/screens/view_details_screens/view_client_details_screen/view_client_details_screen.dart';

import '../../../models/Pet.dart';
import '../../../models/client_model.dart';
import '../../../resources/firebase_firestore_methods.dart';
import '../../view_details_screens/view_client_details_screen/view_client_details_screen.dart';


class PetCardInMainScreen extends StatefulWidget {
  Pet pet;

  PetCardInMainScreen({Key? key, required this.pet}) : super(key: key);

  @override
  State<PetCardInMainScreen> createState() => _PetCardInMainScreenState();
}

class _PetCardInMainScreenState extends State<PetCardInMainScreen> {
  bool loadingNextScreen = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()async{
        setState(() {
          loadingNextScreen = true;
        });
        ClientModel client =  await FirebaseFirestoreMethods()
            .getClientFromFirestore(clientId: widget.pet.clientId!,  );
        setState(() {
          loadingNextScreen = false;
        });

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>   ViewClientDetailsScreen(clientId: widget.pet.clientId!),),
        );

      },
      child: SizedBox(
        width: double.infinity,
        height: 100,
        child: Card(
            child:
                loadingNextScreen ? Center(child: CircularProgressIndicator(),) :

            Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  child: (widget.pet.balance != null && widget.pet.balance != '' &&
                          widget.pet.balance != '0')
                      ? Column(
                    mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(FontAwesome5.hand_holding_usd, color: Colors.red,),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(widget.pet.balance ?? '0', style: const TextStyle(fontWeight: FontWeight.bold),),
                          ),
                        ],
                      )
                      : Icon(FontAwesome5.dog)),
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.pet.getPetName() , style: Get.textTheme.headline5,),
                    Text(widget.pet.getBreed()),
                    Row(
                      children: [
                        ConstrainedBox(

                            constraints: BoxConstraints(
                              maxWidth: Get.width/3
                            ),
                            child: Text(widget.pet.clientName!= null ? widget.pet.clientName! : 'No Breed')),
                        IconButton(
                            onPressed: ()  {
                              Get.to(ViewClientDetailsScreen(
                                  clientId: widget.pet.clientId!));
                            },
                            icon: const Icon(Icons.arrow_circle_right_outlined))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(

                    child: Icon(
                  Icons.vaccines, color: Colors.red,
                ),
                  visible: !widget.pet.isProperlyVaccinated(),
                )
              ],
            )),
            Expanded(
              flex: 1,
              child: Container(
                color: Get.theme.primaryColor,
                child: Center(
                  child: Icon(Icons.arrow_circle_right_outlined, color: Get.theme.backgroundColor,),

                  ),
                ),
              ),

          ],
        )),
      ),
    );
  }
}
