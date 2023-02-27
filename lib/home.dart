import 'dart:io';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quantbit_crm/app_drawer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quantbit_crm/accessToken.dart' as at;
import 'package:url_launcher/url_launcher.dart';

String accessToken = at.tokenAccess;
String greet = "";
List lst = [];
List lst1 = [];
List lst2 = [];
List lst3 = [];

class Data1 {
  final String name;
  final String data;

  const Data1({
    required this.data,
    required this.name,
  });

  factory Data1.fromJson(Map<String, dynamic> json) {
    return Data1(
      data: json['data'],
      name: json['name'],
    );
  }
}

class Data2 {
  final String name;
  final String data;

  const Data2({
    required this.data,
    required this.name,
  });

  factory Data2.fromJson(Map<String, dynamic> json) {
    return Data2(
      data: json['data'],
      name: json['name'],
    );
  }
}

class Data3 {
  final String name;
  final String data;

  const Data3({
    required this.data,
    required this.name,
  });

  factory Data3.fromJson(Map<String, dynamic> json) {
    return Data3(
      data: json['data'],
      name: json['name'],
    );
  }
}

class Data {
  final String company_name;
  final String data;

  const Data({
    required this.data,
    required this.company_name,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      data: json['data'],
      company_name: json['company_name'],
    );
  }
}

whatsapp(String contact) async {
  //var contact = "+917888187242";
  var androidUrl = "whatsapp://send?phone=$contact&text=Hi, I need some help";
  var iosUrl =
      "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";

  try {
    if (Platform.isIOS) {
      await launchUrl(Uri.parse(iosUrl));
    } else {
      await launchUrl(Uri.parse(androidUrl));
    }
  } on Exception {
    Text('WhatsApp is not installed.');
  }
}

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _focusedCalendarDate = DateTime.now();
  DateTime? selectedCalendarDate;
  DateTime _selectedDate = DateTime.now();
  final todaysDate = DateTime.now();
  final _initialCalendarDate = DateTime(2000);
  final _lastCalendarDate = DateTime(2050);
  final titleController = TextEditingController();
  final descpController = TextEditingController();
  late TextEditingController _StartTime;
  late TextEditingController _EndTime;
  late Map<DateTime, List<MyEvents>> mySelectedEvents;
  var hour = DateTime.now().hour;
  
  Future<List<Data>> fetchData() async {
    List<Data> list = [];
    var httpsUri = Uri(
        scheme: 'https',
        host: 'mobilecrm.erpdata.in',
        path: '/api/resource/Lead',
        query: 'fields=["company_name"]');
    var res = await http.get(httpsUri, headers: {
      'Authorization': '$accessToken',
      'Cookie':
          'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
    });
    if (res.statusCode == 200) {
      lst = json.decode(res.body)["data"] as List;
      fetchData();
    }
    return list;
  }

  Future<List<Data1>> fetchcontact() async {
    List<Data1> list1 = [];
    var httpsUri = Uri(
        scheme: 'https',
        host: 'mobilecrm.erpdata.in',
        path: '/api/resource/Contact',
        query: 'fields=["name"]');
    var res = await http.get(httpsUri, headers: {
      'Authorization': '$accessToken',
      'Cookie':
          'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
    });
    if (res.statusCode == 200) {
      lst1 = json.decode(res.body)["data"] as List;
      fetchcontact();
      // print(lst1);
    }
    return list1;
  }

  Future<List<Data2>> fetchoppo() async {
    List<Data2> list2 = [];
    var httpsUri = Uri(
        scheme: 'https',
        host: 'mobilecrm.erpdata.in',
        path: '/api/resource/Opportunity',
        query: 'fields=["title"]');
    var res = await http.get(httpsUri, headers: {
      'Authorization': '$accessToken',
      'Cookie':
          'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
    });
    if (res.statusCode == 200) {
      lst2 = json.decode(res.body)["data"] as List;
      fetchoppo();
      // print(lst2);
    }
    return list2;
  }

  Future<List<Data3>> fetchtask() async {
    List<Data3> list3 = [];
    var httpsUri = Uri(
        scheme: 'https',
        host: 'mobilecrm.erpdata.in',
        path: '/api/resource/Task',
        query: 'fields=["subject"]');
    var res = await http.get(httpsUri, headers: {
      'Authorization': '$accessToken',
      'Cookie':
          'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
    });
    if (res.statusCode == 200) {
      lst3 = json.decode(res.body)["data"] as List;
      fetchtask();
      // print(lst2);
    }
    return list3;
  }

  @override
  void initState() {
    selectedCalendarDate = _focusedCalendarDate;
    mySelectedEvents = {};
    setState(() {
      fetchData();
      fetchcontact();
      fetchoppo();
      fetchtask();

      if (hour < 12) {
        greet = 'Morning';
      } else if (hour < 17) {
        greet = 'Afternoon';
      } else {
        greet = 'Evening';
      }
    });
    super.initState();
    _StartTime = new TextEditingController(
        text: '${DateFormat.jm().format(DateTime.now())}');
    _EndTime = new TextEditingController(
        text: '${DateFormat.jm().format(DateTime.now().add(
      Duration(hours: 1),
    ))}');
  }

  @override
  void dispose() {
    titleController.dispose();
    descpController.dispose();
    super.dispose();
  }

  List<MyEvents> _listOfDayEvents(DateTime dateTime) {
    return mySelectedEvents[dateTime] ?? [];
  }

  _showAddEventDialog() async {
    await showDialog(
        context: context,
        builder: (context) => Expanded(
                child: AlertDialog(
              title: const Text('New Event'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildTextField(
                      controller: titleController, hint: 'Enter Title'),
                  const SizedBox(
                    height: 20.0,
                    width: 20.0,
                  ),
                  buildTextField(
                      controller: descpController, hint: 'Enter Description'),
                  const SizedBox(
                    height: 20.0,
                    width: 20.0,
                  ),
                  buildTextField(
                      controller: descpController, hint: 'Enter meeting link'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (titleController.text.isEmpty &&
                        descpController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter title & description'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                      //Navigator.pop(context);
                      return;
                    } else {
                      setState(() {
                        if (mySelectedEvents[selectedCalendarDate] != null) {
                          mySelectedEvents[selectedCalendarDate]?.add(MyEvents(
                              eventTitle: titleController.text,
                              eventDescp: descpController.text));
                        } else {
                          mySelectedEvents[selectedCalendarDate!] = [
                            MyEvents(
                                eventTitle: titleController.text,
                                eventDescp: descpController.text)
                          ];
                        }
                      });

                      titleController.clear();
                      descpController.clear();

                      Navigator.pop(context);
                      return;
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            )));
  }

  void _onDateChange(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  Widget buildTextField(
      {String? hint, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: hint ?? '',
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 177, 128, 200), width: 1.5),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 51, 7, 72), width: 1.5),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          // Padding(
          //   padding: EdgeInsets.only(right: 20.0),
          //   child: GestureDetector(
          //     onTap: () {},
          //     child: Icon(
          //       Icons.logout,
          //       size: 26.0,
          //     ),
          //   ),
          // ),
          PopupMenuButton(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Logout', 'Add Event'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              }),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Good $greet',
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 20),
                if (greet == "Morning")
                  Icon(Icons.wb_twilight)
                else if (greet == 'Afternoon')
                  Icon(Icons.wb_sunny_outlined)
                else if (greet == 'Evening')
                  Icon(Icons.nightlight_outlined),
              ],
            ),
            SizedBox(height: 25),
            SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    margin: const EdgeInsets.all(8.0),
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: TableCalendar(
                      focusedDay: _focusedCalendarDate,
                      // today's date
                      firstDay: _initialCalendarDate,
                      // earliest possible date
                      lastDay: _lastCalendarDate,
                      // latest allowed date
                      calendarFormat: CalendarFormat.month,
                      // default view when displayed
                      // default is Saturday & Sunday but can be set to any day.
                      // instead of day number can be mentioned as well.
                      weekendDays: const [DateTime.sunday, 7],
                      // default is Sunday but can be changed according to locale
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      // height between the day row and 1st date row, default is 16.0
                      daysOfWeekHeight: 40.0,
                      // height between the date rows, default is 52.0
                      rowHeight: 60.0,
                      // this property needs to be added if we want to show events
                      eventLoader: _listOfDayEvents,
                      // Calendar Header Styling
                      headerStyle: const HeaderStyle(
                        titleTextStyle: TextStyle(
                            color: Color.fromARGB(255, 244, 242, 245),
                            fontSize: 20.0),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 89, 124, 228),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        leftChevronIcon: Icon(
                          Icons.chevron_left,
                          color: Color.fromARGB(255, 243, 239, 239),
                          size: 28,
                        ),
                        rightChevronIcon: Icon(
                          Icons.chevron_right,
                          color: Color.fromARGB(255, 243, 239, 239),
                          size: 28,
                        ),
                      ),
                      // Calendar Days Styling
                      daysOfWeekStyle: const DaysOfWeekStyle(
                        // Weekend days color (Sat,Sun)
                        weekendStyle:
                            TextStyle(color: Color.fromARGB(255, 217, 28, 22)),
                      ),
                      // Calendar Dates styling
                      calendarStyle: const CalendarStyle(
                        // Weekend dates color (Sat & Sun Column)
                        weekendTextStyle:
                            TextStyle(color: Color.fromARGB(255, 217, 28, 22)),
                        // highlighted color for today
                        todayDecoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        // highlighted color for selected day
                        selectedDecoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        markerDecoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 10, 2),
                            shape: BoxShape.circle),
                      ),
                      selectedDayPredicate: (currentSelectedDate) {
                        // as per the documentation 'selectedDayPredicate' needs to determine
                        // current selected day
                        return (isSameDay(
                            selectedCalendarDate!, currentSelectedDate));
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        // as per the documentation
                        if (!isSameDay(selectedCalendarDate, selectedDay)) {
                          setState(() {
                            selectedCalendarDate = selectedDay;
                            _focusedCalendarDate = focusedDay;
                          });
                        }
                      },
                    ),
                  ),
                  ..._listOfDayEvents(selectedCalendarDate!).map(
                    (myEvents) => ListTile(
                      leading: const Icon(
                        Icons.done,
                        color: Color.fromARGB(255, 51, 7, 72),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text('Event Title:   ${myEvents.eventTitle}'),
                      ),
                      subtitle: Text('Description:   ${myEvents.eventDescp}'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      //floatingActionButton: FloatingActionButton(onPressed: (){whatsapp();},child:Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/WhatsApp.svg/768px-WhatsApp.svg.png')),
      drawer: myDrawer(context),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        break;
      case 'Add Event':
        _showAddEventDialog();
        break;
    }
  }
}

class MyEvents {
  final String eventTitle;
  final String eventDescp;

  MyEvents({required this.eventTitle, required this.eventDescp});

  @override
  String toString() => eventTitle;
}
