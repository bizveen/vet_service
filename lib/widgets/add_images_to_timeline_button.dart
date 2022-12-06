
import 'package:flutter/material.dart';

import '../models/complain/Complain.dart';
import '../utils/utils.dart';

class AddTimeLineImagesButtonWidget extends StatefulWidget {
  String clientId;
  String petId;
  Complain? complain;
   AddTimeLineImagesButtonWidget({
    Key? key,
    required this.clientId,
    required this.petId,
   this. complain,

  }) : super(key: key);

  @override
  State<AddTimeLineImagesButtonWidget> createState() => _AddTimeLineImagesButtonWidgetState();
}

class _AddTimeLineImagesButtonWidgetState extends State<AddTimeLineImagesButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return   ElevatedButton(
        onPressed: () async {

          await getImageListDialogBox((comment, images) {
            saveTimeLineImagesToFirebase(
                clientId: widget.clientId ,
                images: images,
                petId: widget.petId ,
                complain: widget.complain,
                comment: comment) ;
          });


          // Get.defaultDialog(
          //     title: 'Add A Time Line Element',
          //     content: StatefulBuilder(builder: (context, innerSetState) {
          //       return SingleChildScrollView(
          //         child: Column(
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             Container(
          //                 height: 60,
          //                 child: TextFormField(
          //                   controller: descriptionController,
          //                   decoration: InputDecoration(
          //                       label: Text('Description')),
          //                   expands: true,
          //                   maxLines: null,
          //                   minLines: null,
          //                 )),
          //             IconButton(
          //                 onPressed: () async {
          //                   Uint8List? image =
          //                       await pickImage(ImageSource.camera);
          //                   if (image != null) {
          //                     //await Future.delayed(Duration(seconds: 1));
          //                     innerSetState(() {
          //                       images.add(image);
          //                     });
          //                   }
          //                 },
          //                 icon: Icon(Icons.camera_enhance)),
          //             Column(
          //                 mainAxisSize: MainAxisSize.min,
          //                 children: images
          //                     .map(
          //                       (e) => SizedBox(
          //                           width: 70,
          //                           height: 100,
          //                           child: Image.memory(e)),
          //                     )
          //                     .toList()),
          //           ],
          //         ),
          //       );
          //     }),
          //     onConfirm: () {
          //       List<ImageModel?>? imageModelList = [];
          //       images.forEach((element) {
          //         imageModelList.add(ImageModel(
          //           image: element,
          //           date:
          //               DateTime.now().microsecondsSinceEpoch.toString(),
          //           id: Uuid().v1(),
          //         ));
          //       });
          //
          //       TimeLineElement timeLimeElement = TimeLineElement(
          //           id: dateTimeDescender(dateTime: DateTime.now()).toString(),
          //           addedById: FirebaseAuth.instance.currentUser!.uid,
          //           addedByName:
          //               FirebaseAuth.instance.currentUser!.displayName,
          //           dateTime: DateTime.now().microsecondsSinceEpoch,
          //           description: descriptionController.text.trim(),
          //         //  images: imageModelList
          //       );
          //
          //     //  Map map =
          //       FirebaseDatabaseMethods().updateBatch(
          //           updateTimeLineJson(
          //           petId: widget.petId,
          //           clientId: widget.clientId,
          //           complain: widget.complain,
          //           json: [timeLimeElement.toJson()],
          //           timeLineId: timeLimeElement.id!));
          //       images.forEach((element) {
          //         FirebaseStorageMethods().uploadImageToStorage(
          //             timeLineElementId: timeLimeElement.id!,
          //             addressPaths: timeLinePaths(
          //
          //                 clientId: widget.clientId,
          //                 petId: widget.petId,
          //                 complain: widget.complain,
          //
          //             ),
          //             file: element,
          //             folderPath: 'pets/${widget.petId}/timeLine',
          //             title: 'Timeline');
          //       });
          //
          //       print(timeLinePaths(
          //           clientId: widget.clientId,
          //           petId: widget.petId,
          //           complain: widget.complain));
          //       Get.back();
          //     });

        },
        child: Text('Add Time Line Element'));
  }
}
