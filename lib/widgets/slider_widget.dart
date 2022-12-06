import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/toggle/gf_toggle.dart';
import 'package:getwidget/getwidget.dart';

class SliderWidget extends StatefulWidget {
  double min;
  double max;
  double value;
  String? label;
  Function(int) onChanged;
  Function(bool) onToggle;

  SliderWidget(
      {Key? key,
      this.label,
      required this.value,
      required this.min,
      required this.max,
      required this.onChanged,
      required this.onToggle,
      })
      : super(key: key);

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double? movingValue;
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            GFToggle(


             duration: const Duration(microseconds: 100),
              onChanged: (value){
              setState(() {
                isVisible = value!;
              });
              widget.onToggle(value!);

            }, value: isVisible ,
              enabledTrackColor: Theme.of(context).primaryColor,),
            isVisible ? Slider(
              autofocus: true,
              label: '${widget.label} : ${movingValue == null ? '':movingValue!.toInt()}',
              divisions: (widget.max - widget.min).toInt(),
              min: widget.min,
              max: widget.max,
              value: widget.value,
              onChanged: (value) {
                //setState(() {
                movingValue = value;
                // });
                widget.onChanged(value.toInt());
              },
            ) : Text('Know ${widget.label}'),
           Spacer(),
            Visibility(
              visible:isVisible ,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: Get.width*0.2),
                  child: FittedBox(
                    child: Text(
                        '${movingValue == null ? 'Select' : movingValue!.floor()}' , overflow: TextOverflow.ellipsis,),
                  ),
                ),
              ),
            )
            // DatePickerWidget(
            //     buttonText: 'Birth Day', pickedDate: (date){
            //   print(date.toString());
            // }),
          ],
        ),
      ),
    );
  }
}
