
import 'view_vaccination_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../models/Vaccination.dart';
import '../../utils/utils.dart';
import '../../utils/tiny_space.dart';

class VaccinationCardWidget extends StatelessWidget {
   VaccinationCardWidget({
    Key? key,
    required this.vaccination,


  }) : super(key: key);

  final Vaccination vaccination;


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListTile(

        leading: SizedBox(
            width: 60,
            height: 80,
            child:(vaccination.images != null && vaccination.images!.isNotEmpty)
                ? Hero(
                tag: 'vaccination.image!.downloadUrl',
                child: Image.network(
                  vaccination.images![0]!
                      .downloadUrl ??
                      '',
                ))
                : Container()),
        // trailing: vaccination.image != null ? CircleAvatar(
        //     backgroundImage:
        //   NetworkImage(
        //     vaccination.image!.downloadUrl!,
        //   ))
        //
        //    : Container(),
        //color: Theme.of(context).colorScheme.primaryContainer,
        onTap: () {
           Get.to(ViewVaccinationDetailsScreen(vaccinationId: vaccination.id! ,));
        },

        title: Row(
          children: [
            vaccination.givenDate!= null ? Text(dateFormatter.format(
                DateTime.fromMicrosecondsSinceEpoch(int.parse(
                    vaccination.givenDate!
                        .toString())))) : Text('No Given Date'),
            TinySpace(),
            Text((vaccination.givenVaccine!.name ?? 'No Name')),
          ],
        ),
        subtitle: Row(
          children: [
            Text('Next'),
            TinySpace(),
            Text(dateFormatter.format(
                DateTime.fromMicrosecondsSinceEpoch(int.parse(
                    vaccination.nextDate!
                        .toString())))),
            TinySpace(),
            Text((vaccination.nextVaccination ??
                'Not Selected')),
          ],
        ),
      ),
    );
  }
}
