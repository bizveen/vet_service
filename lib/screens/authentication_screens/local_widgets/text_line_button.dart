import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextLineButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String firstText;
  final String buttonText;
  bool alignmentRight;

  TextLineButton(
      {Key? key,
      required this.firstText,
      required this.buttonText,
      this.onTap,
      this.alignmentRight = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Container(
        alignment:
            !alignmentRight ? Alignment.centerLeft : Alignment.centerRight,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: firstText,
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color),
                //recognizer: TapGestureRecognizer()..onTap = onTap,
              ),
              TextSpan(
                text: buttonText,
                style: TextStyle(color: Theme.of(context).primaryColor),
                recognizer: TapGestureRecognizer()..onTap = onTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
