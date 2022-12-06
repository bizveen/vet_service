
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';

import 'container_with_border.dart';
import 'gf_button_widget.dart';

class ToggleButtonsWidget extends StatefulWidget {
  Function (List<bool>) selectedList;
  List<String> buttonTextList;
  ToggleButtonsWidget({Key? key , required this.selectedList , required this.buttonTextList}) : super(key: key);

  @override
  State<ToggleButtonsWidget> createState() => _ToggleButtonsWidgetState();
}

class _ToggleButtonsWidgetState extends State<ToggleButtonsWidget> {

  List<bool> selection = [];
List<bool> initialValue = [true];
  @override
  void initState() {

    super.initState();
    selection = List.generate(widget.buttonTextList.length-1, (index) => false);
    selection = initialValue+selection;
  }

  @override
  Widget build(BuildContext context) {
    return ContainerWithBorder(

      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Status'),
            ),


            Container(
              width: Get.width,
              child: Wrap(
                alignment: WrapAlignment.center,
                children: List.generate(
                    widget.buttonTextList.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: GFButtonWidget(

                        animationDuration: 0,
                            onPressed: () {
                              setState(() {
                                selection[index] = !selection[index];
                              });
                              widget.selectedList(selection);
                            },
                            child: Text(
                              widget.buttonTextList[index],
                              style: TextStyle(
                                  color: selection[index]
                                      ? Theme.of(context).backgroundColor
                                      : Theme.of(context).textTheme.bodyText1!.color),
                            ),
                            color: selection[index]
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).secondaryHeaderColor,
                          ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
