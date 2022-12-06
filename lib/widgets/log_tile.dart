
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/log.dart';
import '../utils/utils.dart';

class LogTileWidget extends StatefulWidget {
  Log log;

  LogTileWidget({Key? key, required this.log}) : super(key: key);

  @override
  State<LogTileWidget> createState() => _LogTileWidgetState();
}

class _LogTileWidgetState extends State<LogTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Card(
        child: Row(
          children: [
            Expanded(
                child: Container(
              color: Colors.blueGrey,
              child: Center(
                  child: Icon(widget.log.callLogEntry == null
                      ? Icons.label
                      : widget.log.callLogEntry!.duration == 0
                          ? Icons.phone_disabled_outlined
                          : Icons.call , color: Get.theme.backgroundColor,) ),
            )),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dateIntToFormattedDate(
                        fromMicroSecondsSinceEpoch: widget.log.dateTime!)),
                    Text(widget.log.comment ?? 'No Comment'),
                    Text(widget.log.addedBy! ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
