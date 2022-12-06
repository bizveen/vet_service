import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PetRecordCardWidget extends StatefulWidget {
  String title;
  Widget child;
  Widget leading;
  bool showAddButton;
  bool loadingState;
  Function() onArrowButtonPressed;
  Function() onAddButtonPressed;

  PetRecordCardWidget(
      {Key? key,
      required this.title,
      required this.child,
      required this.leading,
      required this.onAddButtonPressed,
      required this.onArrowButtonPressed,
      this.showAddButton = true,
        this.loadingState = false,
      })
      : super(key: key);

  @override
  State<PetRecordCardWidget> createState() => _PetRecordCardWidgetState();
}

class _PetRecordCardWidgetState extends State<PetRecordCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: widget.loadingState ? SizedBox(
        height: 100,
          child: Center(child: CircularProgressIndicator())) : SizedBox(
        height: 100,
        child: Row(
          children: [
            Expanded(
                child: Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 50,
                      child: Center(child: widget.leading)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.title,
                            style: Get.textTheme.headline6,
                          ),
                        ),
                        Expanded(child: widget.child),
                      ],
                    ),
                  ),
                ],
              ),
            )),
            Container(
              width: Get.width / 8,
              child: Center(
                child: Tooltip(
                    message: 'Show ${widget.title}',
                    child: IconButton(
                      onPressed: widget.onArrowButtonPressed,
                      icon: Icon(
                        Icons.play_arrow_rounded,
                        color: Get.theme.primaryColor,
                      ),
                    )),
              ),
            ),
            Visibility(
              visible: widget.showAddButton,
              child: Container(
                width: 60,
                color: Get.theme.primaryColor,
                child: Center(
                  child: Tooltip(
                    message: 'Add ${widget.title}',
                    child: IconButton(
                      onPressed: widget.onAddButtonPressed,
                      icon: Icon(
                        Icons.add,
                        color: Get.theme.backgroundColor,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
