import 'dart:developer';


import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/badge/gf_badge.dart';
import 'package:getwidget/getwidget.dart';

import '../../models/client_model.dart';
import '../../models/sale/inventory_in.dart';
import '../../models/sale/inventory_out.dart';
import '../../resources/firebase_database_methods.dart';
import '../../utils/tiny_space.dart';

class ProductCard extends StatefulWidget {
  String ? currentActiveCaseId;
  InventoryIn inventoryIn;
  double scale;
  bool showBadges;
  Function(int) selectedQty;

  ProductCard({
    Key? key,
    required this.currentActiveCaseId,
    this.scale = 1,
    this.showBadges = true,
    required this.inventoryIn,
    required this.selectedQty,
  }) : super(key: key);


  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {


  int selectedQty = 0;

  @override
  void initState() {
   List<InventoryOut?> inventoryOutLst
   =  widget.inventoryIn.inventoryOut!.where(
           (element) => element!.id ==widget.currentActiveCaseId!).toList();
   if(inventoryOutLst.isNotEmpty){
     selectedQty = inventoryOutLst.first!.qty!;
   }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        setState(() {
          selectedQty++;
          widget.selectedQty(selectedQty);
        });

      },
      child: Stack(
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .color!
                    .withOpacity(0.2),
                width: 1,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(3),
                topRight: Radius.circular(20),
              ),
            ),
            elevation: 10,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: widget.inventoryIn.image == null
                              ? const CachedNetworkImageProvider(
                                  'https://pic.onlinewebfonts.com/svg/img_566093.png')
                              : CachedNetworkImageProvider(
                                  '${widget.inventoryIn.image!.downloadUrl}',
                                ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      //color: Theme.of(context).colorScheme.primaryContainer,

                      width: 70 * widget.scale,
                      height: 70 * widget.scale,
                    ),
                  ],
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
                            '${widget.inventoryIn.product!.name}',
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
                            '${widget.inventoryIn.retailPrice}',
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
          Positioned(
            top: 2,
            right: 0,
            child: Column(

              children: [
                Visibility(
                  visible: widget.showBadges,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected',
                        style: TextStyle(fontSize: 8),
                      ),
                      GFBadge(
                        color: GFColors.FOCUS,
                        text: selectedQty.toString(),
                      ),
                      TinySpace(),
                      TinySpace(),
                      TinySpace(),
                      Visibility(
                        visible: widget.showBadges,
                        child: Positioned(
                            right: 0,
                            top: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Stock in',
                                  style: TextStyle(fontSize: 8),
                                ),
                                GFBadge(
                                  color: GFColors.FOCUS,
                                  text: widget.inventoryIn.getRemainingQty().toString(),
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
