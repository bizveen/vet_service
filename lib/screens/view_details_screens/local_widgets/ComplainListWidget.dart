
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';

import '../../../models/Pet.dart';
import '../../../models/client_model.dart';
import '../../../models/complain/Complain.dart';
import '../../../resources/database_object_paths/complain_paths.dart';
import '../../../resources/firebase_database_methods.dart';
import '../../../utils/utils.dart';
import '../../../widgets/container_with_border.dart';
import '../../complain_screens/add_complain_screen.dart';
import '../../complain_screens/complain_details_screen.dart';


class ComplainListWidget extends StatelessWidget {
  ComplainListWidget({
    Key? key,

    required this.pet,

  }) : super(key: key);

  final Pet pet;


  @override
  Widget build(BuildContext context) {
    return ContainerWithBorder(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Complains',
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline5
                  // TextStyle(
                  //     color: Theme.of(context).primaryColor, fontSize: 18)
                ),
              ),
              const Spacer(),
              IconButton(icon: const Icon(Icons.add), onPressed: () async {
                Map<dynamic, dynamic> map = await FirebaseDatabaseMethods()
                    .getFirstExaminationCategories();
                Get.to(AddComplainScreen(
                  pet: pet,
                  inspectionMap: map, //this is for creating inspection results objects
                ));
              },)
            ],
          ),

          ListView.builder(
              shrinkWrap: true,
              itemCount: pet.complains!.length,

              itemBuilder: (context, index) {
                return InkWell(
                  onTap: ()async {
                    Get.to(ComplainDetailsScreen(
                        complainId: pet.complains![index]!.id!,
                        clientId: pet.clientId!,
                        complainStatus: ComplainStatus.all, petId: pet.id!,));
                  },
                  child: Padding(

                    padding: const EdgeInsets.all(4.0),

                    child: Text(
                      pet.complains![index]!.getTitle(withPetName: false),
                      style: Get.textTheme.headline5,),

                  ),
                );
              }),
        ],
      ),
    );
  }
}
