import 'dart:typed_data';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/image_picker.dart';
import 'container_with_border.dart';
import 'gf_button_widget.dart';

class ImagePickerWidget extends StatefulWidget {
  final Function(Uint8List?)? pickedImage;
Uint8List ? runningImage ;
   ImagePickerWidget({Key? key, this.pickedImage, this.runningImage}) : super(key: key);

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    _image ?? widget.runningImage;
    return ContainerWithBorder(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text('Image'),
          ),
          Stack(
            children: [
              _image != null
                  ? ContainerWithBorder(
                width: 100,
                      child: InkWell(
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
                        child: Image.memory(
                          _image!,
                          width: 200,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    )
                  //
                  : Container(
                      child: Center(
                        child: GFButtonWidget(
                          onPressed: () async {
                            Uint8List? image =
                                await pickImage(ImageSource.camera);
                            setState(() {
                              _image = image;
                            });
                            widget.pickedImage!(_image!);
                          },
                          name: "Pick Image",
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
          ),
        ],
      ),
    );
  }
}
