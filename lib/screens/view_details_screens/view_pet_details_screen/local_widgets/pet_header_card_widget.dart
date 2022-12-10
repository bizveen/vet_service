import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getwidget/getwidget.dart';
import 'package:string_extensions/string_extensions.dart';

import '../../../../models/Pet.dart';
import '../../../../resources/database_object_paths/other_paths.dart';
import '../../../../resources/firebase_database_methods.dart';
import '../../../../resources/firebase_storage_methods.dart';
import '../../../../utils/tiny_space.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/image_picker_widget.dart';
import '../../../complain_screens/add_complain_screen.dart';
import '../../../pet_timeline_screen.dart';
import '../../view_client_details_screen/view_client_details_screen.dart';

class PetHeaderCard extends StatelessWidget {
  const PetHeaderCard({
    Key? key,
    required this.pet,
    this.image,
  }) : super(key: key);

  final Pet pet;
  final Uint8List? image;

  @override
  Widget build(BuildContext context) {
    // return Stack(
    //   children: [
    //     Image.asset('assets/petAvatar.jfif'),
    //     Positioned(
    //       bottom: 0,
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Container(
    //             width: Get.width,
    //             color: Colors.black.withOpacity(0.6),
    //             child: Center(
    //               child: Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: [
    //                   Text(
    //                     (pet.name ?? 'No Name'),
    //                     style: Get.theme.textTheme.headline3!
    //                         .copyWith(color: Colors.white),
    //                   ),
    //                   Text(
    //                     '${(pet.breed ?? 'No Breed').toTitleCase!} (${pet.gender})',
    //                     style: Get.theme.textTheme.headline5!
    //                         .copyWith(color: Colors.white),
    //                   ),
    //                   Row(
    //                     mainAxisAlignment:
    //                     MainAxisAlignment.spaceAround,
    //                     children: [
    //                       Text(
    //                         'Birth Day : ${pet.birthDay != null ? dateFormatter.format(DateTime.fromMicrosecondsSinceEpoch(pet.birthDay!)) : 'No Birthday'}',
    //                         style: Get.theme.textTheme.bodyText2!
    //                             .copyWith(color: Colors.white),
    //                       ),
    //                       Text(
    //                         'Age : ${pet.birthDay != null ? DateTime.now().difference(DateTime.fromMicrosecondsSinceEpoch(pet.birthDay!)).inDays : 'No'} days',
    //                         style: Get.theme.textTheme.bodyText2!
    //                             .copyWith(color: Colors.white),
    //                       ),
    //                     ],
    //                   ),
    //                   IconButton(
    //                     onPressed: () async {
    //                       Map<dynamic, dynamic> map =
    //                       await FirebaseDatabaseMethods()
    //                           .getFirstExaminationCategories();
    //                       Get.to(AddComplainScreen(
    //                         pet: pet,
    //                         firstInspectionMap: map,
    //                       ));
    //                     },
    //                     icon: const Icon(
    //                       Icons.vaccines,
    //                       color: Colors.white,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     Positioned(
    //       right: 10,
    //       bottom: 50,
    //       child: IconButton(
    //         onPressed: () {
    //           Get.defaultDialog(
    //             title: 'Add an Image',
    //             content: Card(
    //               child: ImagePickerWidget(
    //                 pickedImage: (image) {
    //                   // _image = image;
    //                 },
    //               ),
    //             ),
    //             onConfirm: () {
    //               if (image != null) {
    //                 FirebaseStorageMethods().uploadImageToStorage(
    //                   addressPaths:
    //                   petPaths(clientId: pet.clientId!)
    //                       .map((e) => '$e/${pet.id}')
    //                       .toList(),
    //                   file: image!,
    //                   folderPath: 'pets/${pet.id}',
    //                   title: 'Album',
    //                 );
    //               }
    //               Get.back();
    //             },
    //             onCancel: () {
    //               Get.back();
    //             },
    //           );
    //         },
    //         icon: const Icon(Icons.add_a_photo,
    //             color: Colors.white),
    //       ),
    //     ),
    //     Positioned(
    //       right: 10,
    //       bottom: 70,
    //       child: IconButton(
    //         onPressed: () {
    //           Get.to(PetTimeLine(pet: pet));
    //         },
    //         icon: const Icon(Icons.view_agenda_outlined,
    //             color: Colors.white),
    //       ),
    //     ),
    //   ],
    // );
    return
      Card(
        child:  SizedBox(
    width: MediaQuery.of(context).size.width,
child: Column(
  mainAxisSize: MainAxisSize.min,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
        Row(
          mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:  [
        Padding(
         padding: const EdgeInsets.all(8.0),
         child: Stack(
           children: [
             const CircleAvatar(//backgroundImage: AssetImage('assets/petAvatar.jfif'),
               radius: 50, ),
             Positioned(
               bottom: 0,
                 right: 0,
                 child:
             GFBadge(
                 size: 60, shape: GFBadgeShape.circle,color: Get.theme.primaryColor,
                 child: pet.gender == 'male' ? Icon(Icons.male, size: 30,color: Get.theme.backgroundColor,)
                 : pet.gender == 'female' ? Icon(Icons.female, size: 30,color: Get.theme.backgroundColor,)
                     : Container()))
           ],
         ),
       ),
        TinySpace(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              
              children: [
                TitleWidget(title: 'Pet Name', icon: Icons.pets_outlined),
                Text(((pet.name!=null &&pet.name!='') ?pet.name : 'No Name').toTitleCase!, style: Get.textTheme.headline4,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleWidget(title: 'Client Name', icon: Icons.person, ),
                      SizedBox(
                        width: Get.width/2,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          //  Expanded(child: Text(.toTitleCase!, style: Get.textTheme.headline6,)),
                            TinySpace(),
                            IconButton(onPressed: (){
                              Get.to(ViewClientDetailsScreen(clientId: pet.clientId!, petId: pet.id,));}, icon:  Icon(Icons.arrow_circle_right_outlined, color: Get.theme.primaryColor,))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitleWidget(title: 'Birthday', icon: Icons.cake_outlined),
              Text(pet.birthDay!= null ? dateIntToFormattedDate(fromMicroSecondsSinceEpoch: pet.birthDay!) : 'No Birthday',),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitleWidget(title: 'Breed', icon: Icons.category_outlined),
              Text((pet.breed ?? 'No Breed').toTitleCase!),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitleWidget(title: 'Age', icon: Icons.av_timer),
              Text(pet.knowBirthDay == null ? pet.birthYear?? 'No Birth Details' : pet.birthDay.toString()),
            ],
          ),
        )
      ],
    ),

  ],
),
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
   TitleWidget({
    required this.title,
    required this.icon,
    Key? key,
  }) : super(key: key);
IconData icon;
String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, ),
        TinySpace(height: 0),
        Text(title, style: Get.textTheme.headline6!.copyWith(fontSize: 12), overflow: TextOverflow.ellipsis,)
      ],
    );
  }
}
