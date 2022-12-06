
import 'package:flutter/material.dart';

import '../../models/Contact.dart';
import '../../models/log.dart';
import '../../resources/database_object_paths/log_paths.dart';
import '../../widgets/call_icon_widget.dart';
import '../logs_list_screen.dart';

class CallingScreen extends StatefulWidget {
  List<Contact?>? contactList;
  String clientId;
  LogType logType;
  String? petId;
  String? vaccinationId;
  String? complainId;
  List<Log?>? logList;

  CallingScreen(
      {Key? key,
      required this.contactList,
      required this.logType,
      required this.clientId,
      this.complainId,
      this.petId,
      this.vaccinationId,
        required this.logList,
      })
      : super(key: key);

  @override
  State<CallingScreen> createState() => _CallingScreenState();
}

class _CallingScreenState extends State<CallingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: widget.contactList!
                .map((e) => ListTile(
                      title: Text(e!.contactNumber!),
                      subtitle: Row(
                        children: [
                          Text(e.quickComment ?? 'No Quick Comment'),
                          Text(e.comment ?? 'No Comment'),
                        ],
                      ),
                      trailing: CallIconWidget(

                          petId: widget.petId,
                          clientId: widget.clientId,
                          contactNo: e.contactNumber,
                          logType: widget.logType,
                          complainId: widget.complainId,
                        vaccinationId: widget.vaccinationId,
                      ),
                    ))
                .toList(),
          ),
          Expanded(child: LogsListScreen(logList: widget.logList!))

        ],
      ),
    );
  }
}
