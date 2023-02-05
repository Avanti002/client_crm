import 'package:quantbit_crm/app_drawer.dart';
import 'package:quantbit_crm/face_detection/databse_con.dart';
import 'package:quantbit_crm/face_detection/locator.dart';
import 'package:quantbit_crm/face_detection/face_detection_services/mark_attendance.dart';
import 'package:quantbit_crm/face_detection/face_detection_services/register_face.dart';
import 'package:quantbit_crm/face_detection/face_detection_services/camera_service.dart';
import 'package:quantbit_crm/face_detection/face_detection_services/ml_service.dart';
import 'package:quantbit_crm/face_detection/face_detection_services/face_detector_service.dart';
import 'package:flutter/material.dart';
import 'package:quantbit_crm/home.dart';

class AttendancePage extends StatefulWidget {
  AttendancePage({Key? key}) : super(key: key);
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  TextEditingController apassController = TextEditingController()..text="";
  MLService _mlService = locator<MLService>();
  FaceDetectorService _mlKitService = locator<FaceDetectorService>();
  CameraService _cameraService = locator<CameraService>();
  
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  _initializeServices() async {
    setState(() => loading = true);
    await _cameraService.initialize();
    await _mlService.initialize();
    _mlKitService.initialize();
    setState(() => loading = false);
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
        actions: <Widget>[
          // Padding(
          //   padding: EdgeInsets.only(right: 20, top: 20),
          //   child: PopupMenuButton<String>(
          //     child: Icon(
          //       Icons.more_vert,
          //       color: Colors.black,
          //     ),
          //     onSelected: (value) {
          //       switch (value) {
          //         case 'Clear Records':
          //           DatabaseHelper _dataBaseHelper = DatabaseHelper.instance;
          //           _dataBaseHelper.deleteAll();
          //           break;
          //       }
          //     },
          //     itemBuilder: (BuildContext context) {
          //       return {'Clear Records'}.map((String choice) {
          //         return PopupMenuItem<String>(
          //           value: choice,
          //           child: Text(choice),
          //         );
          //       }).toList();
          //     },
          //   ),
          // ),
          
        ],
      ),
      body: !loading
          ? SingleChildScrollView(
              child: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                     SizedBox(height: 230,),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                  title: const Text('Register Face'),
                                  content: TextField(
                                  style: const TextStyle(color: Colors.black),
                                  controller:apassController,
                                  obscureText:true,
                                  decoration: InputDecoration(
                                  
                                   fillColor: Colors.grey.shade100,
                                   filled: true,
                                   prefixIcon: const Icon(Icons.password), 
                                   hintText: "Admin Password",
                                   border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(10),
                                   )),
                             ),
          actions: <Widget>[
            TextButton(
              onPressed: () =>  {
                if(apassController.text=="abhi@123")
                {
                  Navigator.pop(context),
                  Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                   builder: (BuildContext context) => RegisterFace(),
                                 ),
                               ),

                }
                else
                {
                  Navigator.pop(context),
                  showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
          content: const Text('Wrong Password :('),
          actions: <Widget>[
            TextButton(
              onPressed: () =>  Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
        },
      ),
                  
                }
              
               },
              
              child: const Text('OK'),
            ),
          ],
        );
        },
      );
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (BuildContext context) => RegisterFace(),
                              //   ),
                              // );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.1),
                                    blurRadius: 1,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 16),
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.person, color: Colors.white),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Register Face',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => MarkAttendance(),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.1),
                                    blurRadius: 1,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 16),
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.calendar_month_rounded, color: Colors.white,),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Check-IN / Check-Out',
                                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                                  ), 
                                ],
                              ),
                            ),
                          ), 
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
        context: context,
        builder: (context) {
          DatabaseHelper _dataBaseHelper = DatabaseHelper.instance;
          return AlertDialog(
          title: const Text('Clear Records'),
          content: TextField(
                               style: const TextStyle(color: Colors.black),
                               controller:apassController,
                               obscureText:true,
                               decoration: InputDecoration(
                                  
                                   fillColor: Colors.grey.shade100,
                                   filled: true,
                                   prefixIcon: const Icon(Icons.password), 
                                   hintText: "Admin Password",
                                   border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(10),
                                   )),
                             ),
          actions: <Widget>[
            TextButton(
              onPressed: () =>  {
                
                
                if(apassController.text=="abhi@123")
                {
                  
                        _dataBaseHelper.deleteAll(),
                        Navigator.pop(context),
                        showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
          content: const Text('Cleared all Records !'),
          actions: <Widget>[
            TextButton(
              onPressed: () =>  Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
        },
      ),
                }
                else
                {
                  Navigator.pop(context),
                  showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
          content: const Text('Wrong Password :('),
          actions: <Widget>[
            TextButton(
              onPressed: () =>  Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
        },
      ),
                }
              
               },
              
              child: const Text('OK'),
            ),
          ],
        );
        },
      );
                              
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.1),
                                    blurRadius: 1,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 16),
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.clear, color: Colors.white,),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Clear Records',
                                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                                  ), 
                                ],
                              ),
                            ),
                          ),
                                                  
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
            drawer: myDrawer(context),
    );
  }
}
