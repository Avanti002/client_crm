import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:quantbit_crm/AddNewTask/AddNewTask.dart';

import '../ProjectsPage/ProgressCard.dart';
import 'package:quantbit_crm/side.dart';

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
  void _onDateChange(DateTime date) {
    this.setState(() {
      this._selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'),
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
                  Icons.search,
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

                  SizedBox(height: 10),
                  Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      Text(
                        '${DateFormat('MMM, d').format(this._selectedDate)}',
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 25,
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
                  )
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