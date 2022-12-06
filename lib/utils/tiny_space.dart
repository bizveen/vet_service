import 'package:flutter/material.dart';

class TinySpace extends StatelessWidget {
  double? width;
  double? height;


  TinySpace({Key? key , this.height = 15, this.width = 15}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(height: height, width: width,);
  }
}
