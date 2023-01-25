// ignore_for_file: prefer_typing_uninitialized_variables, avoid_types_as_parameter_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'home.dart';

var loginStatus;
String sCode="";
class MyLogin extends StatefulWidget {
const MyLogin({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  TextEditingController curlController = TextEditingController()..text="demo.erpdata.in";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void usrLogin(String curl,String email,String pass) async { 
    try
    {
    var request =http.Request('GET', Uri.parse('http://$curl/api/method/login?usr=$email&pwd=$pass'));
    http.StreamedResponse response = await request.send(); 
    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((value) {
      loginStatus=value;
      usrLogin(curl,email,pass);
      });
    } 
    else 
    {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
    }
    }catch(e){
      throw Exception(e);
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
              margin: const EdgeInsets.symmetric(vertical: 70,horizontal: 130),
              child:
              Image.asset(
                'assets/hd1.png',
                width: 150.0,
              ),
            ),
          const SizedBox(
            height: 60,
          ),
          Container(
            padding: const EdgeInsets.only(left: 35, top: 50),
          ),
                 Container(
                   padding: EdgeInsets.only(
                       top: MediaQuery.of(context).size.height * 0.3),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Container(
                         margin: const EdgeInsets.only(left: 35, right: 35),
                         child: Column(
                           children: [
                             const Text("Log in",
                           style: TextStyle(
                             height: 1.5,
                             fontSize: 25,
                             color: Colors.black,
                              ),),
                             const SizedBox(
                               height: 20, //<-- SEE HERE
                             ),
                             TextField(
                               style: const TextStyle(color: Colors.black),
                             
                               
                               controller:curlController,
                               decoration: InputDecoration(
                                   fillColor: Colors.grey.shade100,
                                   filled: true,
                                   
                                   hintText: "URL",
                                   border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(10),
                                   )),
                             ),
                             const SizedBox(
                               height: 30,
                             ),

                             TextField(
                               style: const TextStyle(color: Colors.black),
                               controller: emailController,
                               decoration: InputDecoration(
                                   fillColor: Colors.grey.shade100,
                                   filled: true,
                                   hintText: "Email",
                                   border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(10),
                                   )),
                             ),
                             const SizedBox(
                               height: 30,
                             ),
                             TextField(
                               style: const TextStyle(),
                               obscureText: true,
                               controller: passwordController,
                               decoration: InputDecoration(
                                   fillColor: Colors.grey.shade100,
                                   filled: true,
                                   hintText: "Password",
                                   border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(10),
                                   )),
                             ),
                             const SizedBox(
                               height: 40,
                             ),
                         SizedBox(
                           width: 200, // <-- Your width
                           height: 50,
                            child: MaterialButton(
                              padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 10),
                              materialTapTargetSize: MaterialTapTargetSize.padded,
                              color: Colors.blue,
                              height: 50,
                              onPressed: () {                            
                               usrLogin(curlController.text.toString(),emailController.text.toString(),passwordController.text.toString());
                               Timer(const Duration(seconds: 4),() {
                                 sCode=loginStatus.toString();
                               });
                               
                             Timer(const Duration(seconds: 4),() {
                               if(sCode!="null"){
                               if(sCode.substring(12,21)=="Logged In")
                               {
                                             Navigator.push(
                                             context,
                                              MaterialPageRoute(builder: (context) => TasksPage(Goback:(int){} ),)
                                             );
                               }
                               else
                               {
                                if (kDebugMode) {
                                  print("wrong");
                                }
                               }
                               }
                               else{
                                 ScaffoldMessenger.of(context).showSnackBar(
                                 const SnackBar(content: Text('Please Enter correct Username or Password !')));
                               }
                               });
                              },
                              child: const Text('Log in'),
                            ),


                         ),
                           ],
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