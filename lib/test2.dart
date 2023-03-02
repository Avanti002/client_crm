import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:quantbit_crm/accessToken.dart' as at;

String accessToken = at.tokenAccess;

class Data {
  final String status;
  final String attendance_date;
  final String data;

  const Data(
      {required this.data,
      required this.status,
      required this.attendance_date});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        data: json['data'],
        status: json['status'],
        attendance_date: json['attendance_date']);
  }
}

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  AttendancePageState createState() => AttendancePageState();
}

class AttendancePageState extends State<AttendancePage> {
  List<MyEvent> _events = [];

  @override
  void initState() {
    super.initState();
    _fetchAttendanceData();
  }

  Future<void> _fetchAttendanceData() async {
    var httpsUri = Uri(
        scheme: 'https',
        host: 'demo.erpdata.in',
        path: '/api/resource/Issue',
        query: 'fields=["name"]');
    var res = await http.get(httpsUri, headers: {
      'Authorization': accessToken,
      'Cookie':
          'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
    });
    final List<dynamic> attendanceData = jsonDecode(res.body)["data"];
    print(attendanceData);
    setState(() {
      _events = attendanceData
          .map((record) => MyEvent(
                title: 'Attendance',
                start: DateTime.parse(record['date']),
                end: DateTime.parse(record['date']),
              ))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
      ),
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: _AttendanceDataSource(_events),
        monthViewSettings: const MonthViewSettings(showAgenda: true),
      ),
    );
  }
}

class MyEvent {
  String title;
  DateTime start;
  DateTime end;

  MyEvent({required this.title, required this.start, required this.end});
}

class _AttendanceDataSource extends CalendarDataSource {
  _AttendanceDataSource(List<MyEvent> events) {
    appointments = events;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].start;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].end;
  }

  @override
  String getSubject(int index) {
    return appointments![index].title;
  }
}
