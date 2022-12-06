import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../models/Image_model.dart';
import 'firebase_database_methods.dart';

class FirebaseStorageMethods extends GetxController {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> uploadImageToStorage({
    required List<String?>? addressPaths,
    required Uint8List file,
    required String folderPath,
    required String title,
    bool oneImage = false,
    String? timeLineElementId,
  }) async {
    String imageId = const Uuid().v1();
    Reference ref = _storage.ref().child(folderPath).child(imageId);

    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    String firebaseLocation = snap.ref.fullPath;
//List<String> _paths = oneImage ?'$addressPaths/image' :  '$addressPaths/images/$imageId';
    ImageModel imageModel = ImageModel(
        id: imageId,
        downloadUrl: downloadUrl,
        paths:addressPaths,
        storagePath: '$folderPath/$imageId',
      title: title,
      date: DateTime.now().microsecondsSinceEpoch.toString(),
    );

    Map<String, dynamic> mapToUpload ={};
    if(timeLineElementId!=null){
      for (var element in addressPaths!) {
        mapToUpload['$element/$timeLineElementId/images/${imageModel.id}'] = imageModel.toJson();
      }
    }else{
    for (var element in addressPaths!) {
      mapToUpload['$element/images/${imageModel.id}'] = imageModel.toJson();
    }}

    FirebaseDatabaseMethods()
        .updateBatch(mapToUpload);
  }
}
