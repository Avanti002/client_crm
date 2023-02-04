import 'dart:io';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quantbit_crm/app_drawer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';


String greet="";
List lst=[];

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
whatsapp() async{
   var contact = "+917888187242";
   var androidUrl = "whatsapp://send?phone=$contact&text=Hi, I need some help";
   var iosUrl = "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";
   
   try{
      if(Platform.isIOS){
         await launchUrl(Uri.parse(iosUrl));
      }
      else{
         await launchUrl(Uri.parse(androidUrl));
      }
   } on Exception{
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
  DateTime _selectedDate = DateTime.now();
  var hour = DateTime.now().hour;
  Future<List<Data>> fetchData() async {
List<Data> list=[];
var httpsUri = Uri(scheme: 'https',host: 'demo.erpdata.in',path: '/api/resource/Lead',query:'fields=["company_name"]');
var res = await http
.get(httpsUri,headers: {
  'Authorization': 'token da8dde973368af3:f584b09f290bab9',
  'Cookie': 'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
});
if (res.statusCode == 200) {
lst=json.decode(res.body)["data"] as List;
fetchData();
}
return list;
}

  @override
void initState() {
  setState(() {
    fetchData();
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
                  ElevatedButton(onPressed: (){whatsapp();},child:Text('Whatsapp')),
                ],
              ),
      ),
      drawer: myDrawer(context),
                      );
  }
}