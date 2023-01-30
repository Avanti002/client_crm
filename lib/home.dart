import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quantbit_crm/side.dart';
import 'package:table_calendar/table_calendar.dart';


String greet="";
class TasksPage extends StatefulWidget {
  const TasksPage({
    Key? key,
    required this.Goback,
  }) : super(key: key);
  final void Function(int) Goback;
  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  DateTime _selectedDate = DateTime.now();
  var hour = DateTime.now().hour;
  @override
void initState() {
  setState(() {
  if (hour<12) {
          greet='Morning';
  }
  else if (hour < 17) {
        greet='Afternoon';
  }
  else{greet='Evening';}
  });
  super.initState();
}
  void _onDateChange(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NavBar()),
              );
            },
            child: Icon(
              Icons.menu, // add custom icons also
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.logout,
                  size: 26.0,
                ),
              ),
            ),
          ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 30),
                  Text(
                        'Good $greet',
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      
                      Text(
                        'Today : '+'${DateFormat('MMM,d').format(this._selectedDate)}',
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 25),
                  DatePicker(
                    DateTime.now(),
                    initialSelectedDate: this._selectedDate,
                    selectionColor: Colors.blue,
                    onDateChange: this._onDateChange,
                  ),SizedBox(height: 10),
                  TableCalendar(
                  firstDay: DateTime.utc(2000, 04, 18),
                  lastDay: DateTime.utc(2030, 04, 18),
                  focusedDay: DateTime.now(),
                  ),
                  
                ],
              ),
      )
                      );
  }
}

// import 'package:flutter/material.dart';
// import 'package:quantbit_crm/side.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Welcome to Flutter',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Home"),
//           leading: GestureDetector(
//             onTap: () {Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => NavBar()),);
//              },
//             child: Icon(
//               Icons.menu,  // add custom icons also
//             ),
//           ),
//           //   iconTheme: IconThemeData(
//           //
//           //     color: Colors.black, // <-- SEE HERE
//           //   ),
//           //   centerTitle: true,
//           //   actions: [IconButton(
//           //
//           //       onPressed: () {}, icon:  Icon(Icons.menu))],
//           // title: const Text('Welcome to Flutter'),
//         ),
//         body: const Center(
//          //  child: Text('Hello World'),
//         ),
//       ),
//     );
//   }
// }