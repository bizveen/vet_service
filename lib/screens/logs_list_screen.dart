
import 'package:flutter/material.dart';

import '../models/log.dart';
import '../utils/utils.dart';

class LogsListScreen extends StatefulWidget {
  List<Log?> logList;
   LogsListScreen({Key? key, required this.logList}) : super(key: key);

  @override
  State<LogsListScreen> createState() => _LogsListScreenState();
}

class _LogsListScreenState extends State<LogsListScreen> {

  @override
  Widget build(BuildContext context) {
    widget.logList.sort
      ((Log? a, Log? b)=> (a!.id!.compareTo(b!.id!)));

    return Scaffold(
      appBar: AppBar(title: Text('Log List'),),
      body: ListView.builder(
        itemCount: widget.logList.length,
          itemBuilder: (context, index){
          return ListTile(
            leading: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(dateWithTimeFormatter.format(fromDateTimeDescenderValue(int.parse(widget.logList[index]!.id!))).toString()),
                Text(widget.logList[index]!.addedBy??'No Person'),
              ],
            ),
            title: Text(widget.logList[index]!.comment!),
            trailing:widget.logList[index]!.isACall ? Icon(Icons.call) : Icon(Icons.vaccines) ,
          );
          }),
    );
  }
}

