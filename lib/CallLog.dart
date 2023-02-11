import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quantbit_crm/app_drawer.dart';
import 'package:workmanager/workmanager.dart';

///TOP-LEVEL FUNCTION PROVIDED FOR WORK MANAGER AS CALLBACK
void callbackDispatcher() {
  Workmanager().executeTask((dynamic task, dynamic inputData) async {
    print('Background Services are Working!');
    try {
      final Iterable<CallLogEntry> cLog = await CallLog.get();
      print('Queried call log entries');
      for (CallLogEntry entry in cLog) {
        print('-------------------------------------');
        print('F. NUMBER  : ${entry.formattedNumber}');
        print('C.M. NUMBER: ${entry.cachedMatchedNumber}');
        print('NUMBER     : ${entry.number}');
        print('NAME       : ${entry.name}');
        print('TYPE       : ${entry.callType}');
        print(
            'DATE       : ${DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)}');
        print('DURATION   : ${entry.duration}');
        // print('ACCOUNT ID : ${entry.phoneAccountId}');
        print('ACCOUNT ID : ${entry.phoneAccountId}');
        print('SIM NAME   : ${entry.simDisplayName}');
        print('-------------------------------------');
      }
      return true;
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      return true;
    }
  });
}

/// example widget for call log plugin
class CallLogs extends StatefulWidget {
  const CallLogs({super.key});

  @override
  _CallLogsState createState() => _CallLogsState();
}

class _CallLogsState extends State<CallLogs> {
  Iterable<CallLogEntry> _callLogEntries = <CallLogEntry>[];

  @override
  Widget build(BuildContext context) {
    const TextStyle mono = TextStyle(fontFamily: 'monospace');
    final List<Widget> children = <Widget>[];
    for (CallLogEntry entry in _callLogEntries) {
      children.add(Card(
          color: Colors.white,
          borderOnForeground: true,
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ExpansionTile(
                    expandedAlignment: Alignment.centerRight,
                    leading: const Icon(Icons.phone),
                    title: Text('Name : ${entry.name}', style: mono),
                    trailing: Text('${entry.duration} sec', style: mono),
                    children: <Widget>[
                      const SizedBox(width: 80),
                      Row(children: <Widget>[
                        Text('Mobile ${entry.number}', style: mono),
                      ]),
                      const SizedBox(height: 5),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(width: 80),
                                Text('${entry.callType}',
                                    style: mono, textAlign: TextAlign.left),
                              ],
                            ),
                            const SizedBox(width: 100),
                            Row(
                              children: [
                                const Icon(
                                  Icons.sim_card_alert_outlined,
                                  textDirection: TextDirection.rtl,
                                ),
                                Text('${entry.simDisplayName}',
                                    style: mono, textAlign: TextAlign.end),
                              ],
                            )
                          ],
                        ),
                      )
                    ]
                    // const Divider(),
                    // Text('F. NUMBER  : ${entry.formattedNumber}', style: mono),
                    // Text('C.M. NUMBER: ${entry.cachedMatchedNumber}', style: mono),

                    // subtitle:

                    //
                    // Text(
                    //     'DATE       : ${DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)}',
                    //     style: mono),
                    //
                    // Text('ACCOUNT ID : ${entry.phoneAccountId}', style: mono),
                    //
                    )
              ],
            ),
          )));
    }

    return MaterialApp(
      home: Scaffold(
        drawer: myDrawer(context),
        appBar: AppBar(title: const Text('Call Logs'), actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () async {
                final Iterable<CallLogEntry> result = await CallLog.query();
                setState(() {
                  _callLogEntries = result;
                });
              },
              child: const Icon(
                Icons.refresh_outlined,
                size: 26.0,
              ),
            ),
          ),
        ]),
        body: SingleChildScrollView(
          child:
              // Column(
              // children: <Widget>[
              //   Center(
              //     child: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: ElevatedButton(
              //         onPressed: () async {
              //           final Iterable<CallLogEntry> result =
              //               await CallLog.query();
              //           setState(() {
              //             _callLogEntries = result;
              //           });
              //         },
              //         child: const Text('Get all'),
              //       ),
              //     ),
              //   ),
              //   Center(
              //     child: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: ElevatedButton(
              //         onPressed: () {
              //           Workmanager().registerOneOffTask(
              //             DateTime.now().millisecondsSinceEpoch.toString(),
              //             'simpleTask',
              //             existingWorkPolicy: ExistingWorkPolicy.replace,
              //           );
              //         },
              //         child: const Text('Get all in background'),
              //       ),
              //     ),
              //   ),
              Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: children),
          ),
        ),
      ),
    );
  }
}
