import 'package:flutter/material.dart';

import '../../../widgets/container_with_border.dart';
import '../../../widgets/slider_widget.dart';

class BirtDayInputWidget extends StatefulWidget {
  Function(int) getBirthYear;
  Function(int) getBirthMonth;
  Function(int) getBirthDay;

  int? birthYear;
  int? birthMonth;
  int? birthDay;

  late bool showMonth;
  late bool showDay;
  late bool showYear;

  BirtDayInputWidget({
    Key? key,
    required this.getBirthYear,
    required this.getBirthMonth,
    required this.getBirthDay,
    this.birthYear,
    this.birthMonth,
    this.birthDay,
    this.showDay = false,
    this.showMonth = false,
    this.showYear = false,
  }) : super(key: key);

  @override
  State<BirtDayInputWidget> createState() => _BirtDayInputWidgetState();
}

class _BirtDayInputWidgetState extends State<BirtDayInputWidget> {
  late bool showMonth;
  late bool showDay;
  late bool showYear;

  late int birthYear; //=
  late int birthMonth; //= 1;
  late int birthDay; //= 1;

  @override
  void initState() {
    showMonth = widget.showMonth;
    showDay = widget.showDay;
    showYear = widget.showYear;
    birthYear = widget.birthYear ?? DateTime.now().year - 1;
    birthMonth = widget.birthMonth ?? 1;
    birthDay = widget.birthDay ?? 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ContainerWithBorder(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text('Birth Day?'),
          ),
          SliderWidget(
              onToggle: (value) {
                setState(() {
                  showMonth = value;
                  if (value == false) {
                    showMonth = false;
                    showDay = false;
                  }
                });
              },
              label: 'Birth Year',
              value: birthYear.toDouble(),
              min: DateTime.now().year - 20,
              max: (DateTime.now().year).toDouble(),
              onChanged: (value) {
                setState(() {
                  birthYear = value;
                });
                widget.getBirthYear(value.toInt());
              }),
          Visibility(
            visible: showMonth,
            child: SliderWidget(
                onToggle: (value) {
                  setState(() {
                    showDay = value;
                  });
                },
                label: 'Birth Month',
                value: birthMonth.toDouble(),
                min: 1,
                max: 12,
                onChanged: (value) {
                  setState(() {
                    birthMonth = value;
                  });
                  widget.getBirthMonth(value);
                }),
          ),
          Visibility(
            visible: showDay,
            child: SliderWidget(
                onToggle: (value) {},
                label: 'Birth Day',
                value: birthDay.toDouble(),
                min: 1,
                max: 31,
                onChanged: (value) {
                  setState(() {
                    birthDay = value;
                  });
                  widget.getBirthDay(value);
                }),
          ),
        ],
      ),
    );
  }
}
