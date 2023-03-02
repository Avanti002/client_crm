import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  List<MyEvent> _events = [];

  @override
  void initState() {
    super.initState();
    _fetchAttendanceData();
  }

  Future<void> _fetchAttendanceData() async {
    final response =
        await http.get(Uri.parse('https://example.com/api/attendance'));
    final List<dynamic> attendanceData = jsonDecode(response.body);

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
