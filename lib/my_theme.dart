import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class MyTheme {
  ThemeData getTheme() {
    return FlexColorScheme.light(scheme: FlexScheme.aquaBlue).toTheme.copyWith(
          inputDecorationTheme: ThemeData().inputDecorationTheme.copyWith(

            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              border: const OutlineInputBorder(
                gapPadding: 0,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
          ),


      textTheme: ThemeData().textTheme.copyWith(
        titleMedium: const TextStyle(
          color: Colors.blue
        )
      ),
      scaffoldBackgroundColor: Colors.grey[200],
        );
  }
}
