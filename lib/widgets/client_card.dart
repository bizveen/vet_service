
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getwidget/getwidget.dart';

import '../constants.dart';
import '../models/client_model.dart';
import '../models/sale/Sale.dart';
import '../resources/firebase_database_methods.dart';
import '../screens/shop_screens/bill_screen.dart';
import '../screens/view_details_screens/view_client_details_screen/view_client_details_screen.dart';

class ClientCard extends StatefulWidget {
  ClientModel client;
   ClientCard({Key? key , required this.client, }) : super(key: key);

  @override
  State<ClientCard> createState() => _ClientCardState();
}

class _ClientCardState extends State<ClientCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        Get.to(ViewClientDetailsScreen(clientId: widget.client.id!));
      },
      title: Text
        (widget.client.name ?? 'No Name'),
      subtitle:
          Column(
            children: [
              widget.client.pets!=null && widget.client.pets!.isNotEmpty ?  Row(
                children: widget.client.pets!.map((e) => Text('${e!.name ?? "No Name"} ' )).toList(),

              ) : Container(),
              widget.client.isActive != null
                  ? widget.client.isActive!
                  ? FirebaseDatabaseListView(
                shrinkWrap: true,
                query: FirebaseDatabaseMethods()
                    .reference(path: 'clients/${widget.client.id}/sales')
                    .orderByChild('isActive').equalTo(true),

                itemBuilder: (context, snapshot) {

                  Sale sale = Sale.fromJson(
                      snapshot.value as Map<dynamic, dynamic>);
                  return sale.isActive! ? InkWell(
                    onTap: (){
                      Get.to(()=>BillScreen(sale: sale,));
                    },
                    child: Container(
                      height: 30,
                      color: Colors.red.withOpacity(0.2),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          const Text('Bill'),
                          Text(((sale.getTotalCharges() != 0 ? sale.getTotalCharges() : '0'))
                              .toString()),
                        ],
                      ),
                    ),
                  ) : Container();
                },
              )
                  : Container()
                  : Container()
            ],
          ),

      trailing: Visibility(
        visible: widget.client.isActive ?? false,
          child: GFBadge(color: Colors.red, shape: GFBadgeShape.circle,)
      ),
    );

  }
}
