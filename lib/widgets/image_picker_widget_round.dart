import 'dart:typed_data';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/image_picker.dart';
import 'container_with_border.dart';
import 'gf_button_widget.dart';

class ImagePickerWidgetRound extends StatefulWidget {
  final Function(Uint8List?)? pickedImage;
  Uint8List? image ;
Uint8List ? runningImage ;
   ImagePickerWidgetRound({Key? key, this.pickedImage, this.runningImage, this.image
   }) : super(key: key);

  @override
  State<ImagePickerWidgetRound> createState() => _ImagePickerWidgetRoundState();
}

class _ImagePickerWidgetRoundState extends State<ImagePickerWidgetRound> {

  Uint8List? _image;
@override
  void initState() {

    super.initState();
    _image = widget.image;
  }
  @override
  Widget build(BuildContext context) {
    _image ?? widget.runningImage;
    return Stack(
      children: [
        _image != null
            ? InkWell(
              onTap: () {
                Get.dialog(
                  InteractiveViewer(
                    child: Image.memory(
                      _image!,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                );
              },
              child: GFAvatar(
                size: 70,
backgroundImage: MemoryImage(
              _image!,

              ),
                // child: Image.memory(
                //   _image!,
                //   width: 200,
                //   fit: BoxFit.fitWidth,
                // ),

              ),
            )
            //
            : Center(
              child: GFAvatar(
                size: 70,
                child: IconButton(
                  onPressed: () async {
                    Uint8List? image =
                        await pickImage(ImageSource.camera);
                    setState(() {
                      _image = image;
                    });
                    widget.pickedImage!(_image!);
                  },
                  icon:Icon(Icons.camera_alt_outlined),
                ),
              ),
            ),
        _image != null
            ? Positioned(
                bottom: 4,
                right: 4,
                child: GFIconButton(
                  iconSize: 12,
                  size: 12,
                  type: GFButtonType.solid,
                  onPressed: () async {
                    setState(() {
                      _image = null;
                    });
                    widget.pickedImage!(null);
                  },
                  icon: const Icon(
                    Icons.delete,
                  ),
                ))
            : Container(),
      ],
    );
  }
}
