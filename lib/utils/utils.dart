import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:uuid/uuid.dart';
import 'package:vet_service/resources/firebase_firestore_methods.dart';

import '../models/Image_model.dart';
import '../models/TimeLineElement.dart';
import '../models/client_model.dart';
import '../models/complain/Complain.dart';
import '../resources/database_object_paths/time_line_paths.dart';
import '../resources/firebase_database_methods.dart';
import '../resources/firebase_storage_methods.dart';
import 'image_picker.dart';

class Utils {
  String removeCommas(String text) {
    String removeDoubleCommas = text.replaceAll(',,', ',');
    if (text.length > 1) {
      return removeDoubleCommas
          .substring(0, (removeDoubleCommas.length - 1))
          .replaceAll(',', ', ');
    } else {
      return text;
    }
  }
}

DateFormat dateFormatter = DateFormat('yyyy/MM/dd');
DateFormat dateWithTimeFormatter = DateFormat('yyyy/MM/dd h:mm a');

DateTime fromDateTimeDescenderValue(int dateTimeDescender) {
  return DateTime.fromMicrosecondsSinceEpoch(
      DateTime(3000).microsecondsSinceEpoch - dateTimeDescender);
}

ClientModel loadingClient = ClientModel(clientStatus: ClientStatus.fake.index,
    name: "Loading" , address: "Loading", area: "Loading", id: "Loading" , doctorId: "Loading" , );
int? dateTimeDescender({
  int? fromMicroSecondsSinceApoc,
  DateTime? dateTime,
}) {
  if (fromMicroSecondsSinceApoc != null) {
    return DateTime(3000).microsecondsSinceEpoch - fromMicroSecondsSinceApoc;
  } else if (dateTime != null) {
    return DateTime(3000).microsecondsSinceEpoch -
        dateTime.microsecondsSinceEpoch;
  } else {
    return null;
  }
}

Map<dynamic, dynamic> dataSnapShotListToMap(
    {required Iterable<DataSnapshot> children}) {
  Map<dynamic, dynamic> map = {};
  children.forEach((element) {
    map[element.key] = element.value;
  });
  return map;
}

String dateIntToFormattedDate({required int fromMicroSecondsSinceEpoch}) {
  return dateFormatter
      .format(DateTime.fromMicrosecondsSinceEpoch(fromMicroSecondsSinceEpoch));
}

String dateIntToFormattedDateWithTime(
    {required int fromMicroSecondsSinceEpoch}) {
  return dateWithTimeFormatter
      .format(DateTime.fromMicrosecondsSinceEpoch(fromMicroSecondsSinceEpoch));
}

Future<void> getImageListDialogBox(
    Function(String comment, List<Uint8List> images) getValues) async {
  TextEditingController descriptionController = TextEditingController();
  List<Uint8List>? images = [];
  await Get.defaultDialog(
      title: 'Add A Time Line Element',
      content: StatefulBuilder(
        builder: (context, innerSetState) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    height: 60,
                    child: TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(label: Text('Description')),
                      expands: true,
                      maxLines: null,
                      minLines: null,
                    )),
                IconButton(
                    onPressed: () async {
                      Uint8List? image = await pickImage(ImageSource.camera);
                      if (image != null) {
                        //await Future.delayed(Duration(seconds: 1));
                        innerSetState(() {
                          images.add(image);
                        });
                      }
                    },
                    icon: Icon(Icons.camera_enhance)),
                Column(
                    mainAxisSize: MainAxisSize.min,
                    children: images
                        .map(
                          (e) => SizedBox(
                              width: 70, height: 100, child: Image.memory(e)),
                        )
                        .toList()),
              ],
            ),
          );
        },
      ),
      onConfirm: () {
        getValues(descriptionController.text.trim(), images);
        // List<ImageModel?>? imageModelList = [];
        // images.forEach((element) {
        //   imageModelList.add(ImageModel(
        //     image: element,
        //     date:
        //     DateTime.now().microsecondsSinceEpoch.toString(),
        //     id: Uuid().v1(),
        //   ));
        // });

        Get.back();
      });
}

// Future<void> saveTimeLineImagesToFirebase(
//     {List<Uint8List>? images,
//     String? comment,
//     required String petId,
//     required String clientId,
//     Complain? complain}) async {
//   List<ImageModel?>? imageModelList = [];
//   if (images != null) {
//     images.forEach((element) {
//       imageModelList.add(ImageModel(
//         fileType: FileType.timeLineImage.index,
//         image: element,
//         date: DateTime
//             .now()
//             .microsecondsSinceEpoch
//             .toString(),
//         id: Uuid().v1(),
//       ));
//     });
//   }
//   TimeLineElement timeLimeElement = TimeLineElement(
//       id: dateTimeDescender(dateTime: DateTime.now()).toString(),
//       addedById: FirebaseAuth.instance.currentUser!.uid,
//       addedByName: FirebaseAuth.instance.currentUser!.displayName,
//       dateTime: DateTime
//           .now()
//           .microsecondsSinceEpoch,
//       description: comment,
//       images: imageModelList
//   );
//
//   //  Map map =
//   // await FirebaseDatabaseMethods().updateBatch(updateTimeLineJson(
//   //     petId: petId,
//   //     clientId: clientId,
//   //     complain: complain,
//   //     json: [timeLimeElement.toJson()],
//   //     timeLineId: timeLimeElement.id!));
//
//   if (images != null) {
//     images.forEach((element) async {
//       await FirebaseStorageMethods().uploadImageToStorage(
//           timeLineElementId: timeLimeElement.id!,
//           fileType: FileType.timeLineImage,
//           petId: petId,
//           clientId: clientId,
//           file: element,
//
//
//           title: 'Timeline');
//     });
//     // }
//     await FirebaseFirestoreMethods().firestore.collection("clients").doc(clientId).update(
//         {
//           'pets.$petId.timeLine.${timeLimeElement.id}' : timeLimeElement.toJson()
//         });
//   }}
    showToast({required String message}) {
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    DateTime? stringToDate(String? dateTime) {
      if (dateTime == null) {
        return null;
      }
      if (!(dateTime.split('/')[0].isNumber)) {
        return null;
      }
      if (dateTime
          .split(' ')
          .length > 1) {
        return DateTime(
          int.parse(dateTime.split('/')[2] != null
              ? dateTime.split('/')[2].substring(0, 4)
              : '0'),
          int.parse(dateTime.split('/')[0] ?? '0'),
          int.parse(dateTime.split('/')[1] ?? '0'),
          int.parse(dateTime.split(':')[0].substring(
              dateTime.split(':')[0].length - 2,
              dateTime.split(':')[0].length)),
          int.parse(dateTime
              .split(':')
              .length > 1 ? dateTime.split(':')[1] : '0'),
          int.parse(dateTime
              .split(':')
              .length > 2 ? dateTime.split(':')[2] : '0'),
        );
      } else {
        print(dateTime);
        return DateTime(
          int.parse(dateTime.split('/')[2] != null
              ? dateTime.split('/')[2].substring(0, 4)
              : '0'),
          int.parse(dateTime.split('/')[0] ?? '0'),
          int.parse(dateTime.split('/')[1] ?? '0'),
        );
      }
    }
