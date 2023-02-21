import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quantbit_crm/app_drawer.dart';
import 'package:quantbit_crm/home.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:quantbit_crm/backend/post_meeting.dart';

String date="";
String time1="";
String time2="";
String start="";
String end="";
DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
DateTime dateT=dateFormat.parse(start);

// DateFormat dateFormat1 = DateFormat("dd-MM-yyyy HH:mm:ss");
// DateTime dateTime5 = dateFormat1.parse(end);



class CreateMeet extends StatefulWidget {
  const CreateMeet({Key? key}) : super(key: key);

  @override
  State<CreateMeet> createState() => _CreateMeetState();
}

class _CreateMeetState extends State<CreateMeet> {
  String? subject;
  String? starts_on;
  DateTime? ends_on;
  String? description;
  String? meeting_link;

  late TextEditingController _Titlecontroller;
  late TextEditingController _Datecontroller;
  late TextEditingController _StartTime;
  late TextEditingController _EndTime;
  DateTime SelectedDate = DateTime.now();
  String Category = "Meeting";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _Titlecontroller = new TextEditingController();
    _Datecontroller = new TextEditingController(
        text: '${DateFormat('yyyy-MM-dd').format(this.SelectedDate)}');
    _StartTime = new TextEditingController(
        text: '${DateFormat.jm().format(DateTime.now())}');
    _EndTime = new TextEditingController(
        text: '${DateFormat.jm().format(DateTime.now().add(
          Duration(hours: 1),
        ))}');
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: SelectedDate,
      firstDate: DateTime(2005),
      lastDate: DateTime(2030),
    );
    if (selected != null && selected != SelectedDate) {
      setState(() {
        SelectedDate = selected;
        _Datecontroller.text =
        '${DateFormat('yyyy-MM-dd').format(selected)}';
      });
    }
  }

  _selectTime(BuildContext context, String Timetype) async {
    final TimeOfDay? result =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        if (Timetype == "StartTime") {
          _StartTime.text = result.format(context);
        } else {
          _EndTime.text = result.format(context);
        }
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        drawer: myDrawer(context),
        appBar: AppBar(
            title: Text("Create New Meet"),
            
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () =>launch('https://meet.google.com/?hs=197&pli=1&authuser=0'),
                  child: const Icon(
                    Icons.video_call_rounded,
                    size: 26.0,
                  ),
                ),
              ),
            ]),
        body: SafeArea(
        child: Container(
          color: Colors.white,


            child: Column(
              children: [


                
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),

                  child: TextFormField(
                    controller: _Titlecontroller,
                    cursorColor: Colors.black,
                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                      labelText: "Subject",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      fillColor: Colors.black,
                      labelStyle: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    onChanged: ((value) {
                      setState(() {
                        subject = value;
                      });
                    }),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  child: TextFormField(
                    controller: _Datecontroller,

                    cursorColor: Colors.black,
                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Date",
                      suffixIcon: GestureDetector(
                        onTap: () {
                         _selectDate(context);
                         date=_Datecontroller.text.toString();
                        //print(date);





                        },

                        child: Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      fillColor: Colors.black,
                      labelStyle: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 10,


                      ),
                    ),
                  ),
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: TextField(
                                readOnly: true,
                                controller: _StartTime,
                                decoration: InputDecoration(
                                  labelText: "Start Time",
                                  suffixIcon: GestureDetector(
                                    onTap: () {

                                      _selectTime(context, "StartTime");
                                      time2=_StartTime.text.toString();
                                      DateTime dateTime = DateFormat('h:mm a').parse(time2);
                                      String formattedTime = DateFormat('HH:mm:ss').format(dateTime);

                                      start=date+" "+formattedTime;
                                     // print(start);


                                     // DateTime dateT=dateFormat.parse(start);

                                      // DateTime dateT = dateFormat.parse(start);
                                      // print(dateT);



                                      // DateTime dateTime1 = DateTime.parse(start);
                                      // print(start);// Output: 18:45:00
                                    },



                                    child: Icon(
                                      Icons.alarm,
                                      color: Colors.black,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.black),
                                  ),
                                  fillColor: Colors.black,
                                  labelStyle: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                                  onChanged: (start) {

                                  setState(() {


                                      print(start);
                                      starts_on = start;
                                      // print(ends_on);
                                    });
                                  }



                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  child: TextField(

                                    //readOnly: true,
                                    controller: _EndTime,

                                    decoration: InputDecoration(
                                      labelText: "End Time",
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          _selectTime(context, "EndTime");
                                          time1=_EndTime.text.toString();


                                          DateTime dateTime1 = DateFormat('h:mm a').parse(time1);
                                          String formattedTime1 = DateFormat('HH:mm:ss').format(dateTime1);
                                          print(formattedTime1);

                                          end=date+" "+formattedTime1 ;

                                          // dateTime5 = dateFormat.parse(end);
                                          // print(dateTime5);
                                          //DateFormat dateFormat1 = DateFormat("dd-MM-yyyy HH:mm:ss");


                                        },


                                        child: Icon(
                                          Icons.alarm,
                                          color: Colors.black,
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.black),
                                      ),
                                      fillColor: Colors.black,
                                      labelStyle: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),

                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child:
                          TextFormField(
                          keyboardType: TextInputType.multiline,
                          minLines: 1,

                          cursorColor: Colors.black,
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                            labelText: "Description",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            fillColor: Colors.black,
                            labelStyle: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                              onChanged: (value) {
                                setState(() {
                                  description = value;
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              }
                        ),



                       ),


                      Container(
                        padding: EdgeInsets.all(15),

                        alignment: Alignment.center,
                        child:
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          minLines: 1,

                          cursorColor: Colors.black,
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                            labelText: "Meeting Link",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            fillColor: Colors.black,
                            labelStyle: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                            onChanged: (value) {
                              setState(() {
                                meeting_link = value;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            }
                        ),


                      ),
                      SizedBox(
                        height: 101,
                      ),
                      Center(
                        child:ElevatedButton(
                            onPressed: ()=>{
                            Navigator.pop(context,
                            MaterialPageRoute(builder: (context)=> const CreateMeet())),
                            postMeeting(subject,starts_on,ends_on,description,meeting_link),
                            },
                            child:new Text('Create Meeting'),
                          ),

                      ),







                        // padding: EdgeInsets.all(15),
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(20),
                        //   color: Colors.blue,
                        // ),
                        // alignment: Alignment.center,
                        // child: Text(
                        //   "Create Meeting",
                        //   style: GoogleFonts.montserrat(
                        //     color: Colors.white,
                        //     fontSize: 18,
                        //     fontWeight: FontWeight.normal,
                        //   ),
                        //
                        // ),

                    ],
                  ),

              ],
            ),

          ),

      )
        ));


  }
}
