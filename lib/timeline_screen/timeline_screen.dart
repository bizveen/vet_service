import 'dart:typed_data';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:dio/dio.dart' as dioDart;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../models/Image_model.dart';
import '../models/TimeLineElement.dart';
import '../models/complain/Complain.dart';
import '../resources/database_object_paths/time_line_paths.dart';
import '../resources/firebase_database_methods.dart';
import '../utils/image_picker.dart';
import '../utils/utils.dart';

class TimelineScreen extends StatefulWidget {
  String clientId;
  String petId;
  Complain? complain;

  TimelineScreen(
      {Key? key, required this.clientId, this.complain, required this.petId})
      : super(key: key);

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  List<TimeLineElement> timeLineElementList = [];
  List<Uint8List> _images = [];
String? _comment;
  @override
  void dispose() {

    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Line'),

      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
              onPressed: () async {
                _images.clear();
                await getImageListDialogBox((comment, images) {
                  _images = images;
                  _comment = comment;
                });
                   saveTimeLineImagesToFirebase(clientId: widget.clientId , images: _images, petId: widget.petId , complain: widget.complain, comment: _comment) ;

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
                setState(() {

                });
              },
              child: Text('Add Time Line Element')),
          Expanded(

            child: FirebaseDatabaseListView(
              shrinkWrap: true,
                query: widget.complain != null
                    ? FirebaseDatabaseMethods().reference(path: 'complains/all/${widget.complain!.id!}/timeLine')
                 : FirebaseDatabaseMethods().reference(path: 'pets/${widget.petId}/timeLine')
                ,
                itemBuilder: (context , snapshot){
                  TimeLineElement timeLineElement = TimeLineElement.fromJson(snapshot.value);
                  return TimelineTile(
                    alignment: TimelineAlign.manual,
                    lineXY: 0.3,
                    startChild:
                    Container(


                      child:  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(dateIntToFormattedDateWithTime(
                            fromMicroSecondsSinceEpoch: timeLineElement.dateTime!)),
                      ),

                    ),
                    endChild: Container(
                      constraints: const BoxConstraints(
                        minHeight: 120,

                      ),

                      child: Column(
                        children: [
Text(timeLineElement.description ?? ''),
                          Expanded(

                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: (timeLineElement.images!=null && timeLineElement.images!.isNotEmpty)
                                    ? timeLineElement.images!.map((e) => SizedBox(height: 150, width: 100 ,
                                  child: InkWell(
                                      onTap: () {
//                                         Get.defaultDialog(
//                                           title: 'Image',
//                                          actions: [
//                                            IconButton(onPressed: () async{
//                                              dioDart.Response response;
//                                              var dio = dioDart.Dio();
//                                              print(await Permission.storage.status);
//                                              if (await Permission.storage.isGranted) {
//                                                // Either the permission was already granted before or the user just granted it.
//                                                Directory dir = await getApplicationDocumentsDirectory();
//
//                                                response = await dio.download(e!.downloadUrl! , '${dir.path}/images');
//                                              } else if (await Permission.storage.isDenied){
//
//
//                                              }else{
//                                                print('No Permission');
//                                              }
// // getting a directory path for saving
//
//                                            }, icon: Icon(Icons.download))],
//                                          onCancel: (){
//                                             Get.back();
//                                          },
//                                          content : InteractiveViewer(
//                                             child: CachedNetworkImage(imageUrl: e!.downloadUrl!,),
//                                           ),
//                                         );
                                      //TODO : Need to do this
                                      },

                                      child: CachedNetworkImage(imageUrl: e!.downloadUrl!,)),)).toList()
                                    : [Text("No Images")] ,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}