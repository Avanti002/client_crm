import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quantbit_crm/app_drawer.dart';
import 'package:table_calendar/table_calendar.dart';


String greet="";
class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);
 
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
      ),
      drawer: myDrawer(context),
                      );
  }
}