
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/Pet.dart';
import '../models/client_model.dart';
import '../screens/view_details_screens/view_client_details_screen/view_client_details_screen.dart';
import '../screens/view_details_screens/view_pet_details_screen/view_pet_details_screen.dart';

class PetCard2 extends StatefulWidget {
  Pet pet;
  bool isSelected;
ClientModel? client;
  double scale;

  PetCard2({Key? key, required this.pet, this.scale = 1  ,  this.client , this.isSelected = false}) : super(key: key);

  @override
  State<PetCard2> createState() => _PetCard2State();
}

class _PetCard2State extends State<PetCard2> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {

        //  Get.to(AddPetScreen(pet: widget.pet, client: widget.client,));
        //   Get.to(
        //       ViewPetDetailsScreen(
        //           pet: widget.pet, client: widget.client!), );


          },
          child: Card(
            clipBehavior: Clip.antiAlias,

            shape: RoundedRectangleBorder(
              side: widget.isSelected ?  BorderSide(
                color:
                    Theme.of(context).primaryColor,
                width: 5,

              ) :
              BorderSide(
                color:
                Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.2),
                width: 1,
              )
              ,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(3),
                topRight: Radius.circular(20),
              ),
            ),
            elevation: 10,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: widget.pet.timeLine!.isEmpty
                          ? const CachedNetworkImageProvider(
                              'https://tse3.mm.bing.net/th?id=OIP.6a6-zJFP78MfdKnZnxf3ewAAAA')
                          : CachedNetworkImageProvider(
                              '${widget.pet.timeLine![ widget.pet.timeLine!.length-1]!.images![0]?.downloadUrl!}',
                            ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  //color: Theme.of(context).colorScheme.primaryContainer,

                  width: 70 * widget.scale,
                  height: 70 * widget.scale,
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 60 * widget.scale,
                        height: 20 * widget.scale,
                        child: FittedBox(
                          child: Text(
                            '${widget.pet.name}',
                            style: TextStyle(
                              fontSize: 14 * widget.scale,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20 * widget.scale,
                      ),
                      SizedBox(
                        width: 60 * widget.scale,
                        height: 10 * widget.scale,
                        child: FittedBox(
                          child: Text(
                            '${widget.pet.breed}',
                            style: TextStyle(
                              fontSize: 10 * widget.scale,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }
}
