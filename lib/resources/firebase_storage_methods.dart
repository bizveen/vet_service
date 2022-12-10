import 'dart:typed_data';


import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:vet_service/constants.dart';
import 'package:vet_service/resources/firebase_firestore_methods.dart';

import '../models/Image_model.dart';
import 'firebase_database_methods.dart';

enum FileType {petImage, complainImage, vaccinationImage, timeLineImage, productImage}

class FirebaseStorageMethods extends GetxController {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> uploadImageToStorage({
    required FileType fileType,
    required Uint8List file,
    required String title,
    String? clientId,
     String? petId,
    String? vaccinationId,
    String? complainId,
    String? inventoryInId,
    bool oneImage = false,
   String? timeLineElementId,
  }) async {

    String imageBucketPath = 'clients/$clientId/pets/$petId';

    if(fileType== FileType.vaccinationImage){
      imageBucketPath = '$imageBucketPath/vaccinations/$vaccinationId';
    } else if(fileType== FileType.complainImage){
      imageBucketPath = '$imageBucketPath/complains/$complainId';
    } else if(fileType== FileType.productImage){
      imageBucketPath = '$doctorId/products';
    }

    String imageId = const Uuid().v1();
    Reference ref = _storage.ref().child(imageBucketPath).child(imageId);

    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    String firebaseLocation = snap.ref.fullPath;
//List<String> _paths = oneImage ?'$addressPaths/image' :  '$addressPaths/images/$imageId';
    ImageModel imageModel = ImageModel(
      fileType: fileType.index,
        id: imageId,
        downloadUrl: downloadUrl,
        storagePath: '$imageBucketPath/$imageId',
      title: title,
      date: DateTime.now().microsecondsSinceEpoch.toString(),
    );

String imageSubPath = 'pets.$petId';
if(vaccinationId!= null){
  imageSubPath = '$imageSubPath.vaccinations.$vaccinationId';
}else if(complainId!=null){
  imageSubPath = '$imageSubPath.complains.$complainId';
} else if(inventoryInId!=null){
  imageSubPath = '$doctorPath.inventoryIn.$inventoryInId'; //Doctor Path is Added
}else if(timeLineElementId!=null){
  imageSubPath = '$imageSubPath.timeLine.$timeLineElementId';
}


    FirebaseFirestoreMethods().firestore.collection('clients').doc(clientId).update(
        { '$imageSubPath.images.$imageId': imageModel.toJson()});
  }
}
