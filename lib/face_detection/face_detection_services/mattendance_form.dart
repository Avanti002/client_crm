import 'package:quantbit_crm/face_detection/locator.dart';
import 'package:quantbit_crm/face_detection/user_model.dart';
import 'package:quantbit_crm/face_detection/profile.dart';
import 'package:quantbit_crm/face_detection/face_detection_services/app_button.dart';
import 'package:quantbit_crm/face_detection/face_detection_services/app_text_field.dart';
import 'package:quantbit_crm/face_detection/face_detection_services/camera_service.dart';
import 'package:flutter/material.dart';
import 'package:quantbit_crm/home.dart';

class MarkAttendanceSheet extends StatelessWidget {
  MarkAttendanceSheet({Key? key, required this.user}) : super(key: key);
  final User user;

  final _passwordController = TextEditingController();
  final _cameraService = locator<CameraService>();

  Future _signIn(context, user) async {
    if (user.password == _passwordController.text) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
          title: const Text('Success :)'),
          content: const Text('Attendance Marked !'),
          actions: <Widget>[
            TextButton(
              onPressed: () =>  Navigator.push(
           context,
           MaterialPageRoute(
               builder: (BuildContext context) => Home())),
              child: const Text('OK'),
            ),
          ],
        );
        },
      );
      
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (BuildContext context) => Profile(
      //               user.user,
      //               imagePath: _cameraService.imagePath!,
      //             )));
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
          title: const Text('Failed :('),
          content: const Text('Wrong Password !'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        );
        },
      );
    }
  }
  
  String? checkinout="CheckIn";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              'Welcome, ' + user.user + '.',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            child: Column(
              children: [
                SizedBox(height: 10),
                RadioListTile(
                    title: Text("CheckIn"),
                    value: "CheckIn", 
                    groupValue: checkinout, 
                    onChanged: (value){
                      
                          checkinout = value.toString();
                      
                    },
                ),
                RadioListTile(
                    title: Text("CheckOut"),
                    value: "CheckOut", 
                    groupValue: checkinout, 
                    onChanged: (value){ 
                          checkinout = value.toString();
                    },
                ),
                SizedBox(height: 10),
                AppTextField(
                  controller: _passwordController,
                  labelText: "Password",
                  isPassword: true,
                ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                AppButton(
                  text: 'Mark Attendance',
                  onPressed: () async {
                    _signIn(context, user);
                  },
                  icon: Icon(
                    Icons.calendar_month_rounded,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
