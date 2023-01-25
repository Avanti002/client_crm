// ignore_for_file: prefer_typing_uninitialized_variables, avoid_types_as_parameter_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'home.dart';

var loginStatus;
String sCode="";
String usernm="";
String emailid="";
String password="";
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
      emailid=email;
      password=pass;
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
                   padding: EdgeInsets.only(
                       top: MediaQuery.of(context).size.height * 0.2),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Container(
                         margin: const EdgeInsets.only(left: 35, right: 35),
                         child: Column(
                           children: [
                            Image.network(
                  'https://scontent.fpnq7-3.fna.fbcdn.net/v/t39.30808-6/298901972_439781191497646_6645786026494038575_n.png?_nc_cat=104&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=vymLlBzEmVQAX889w05&_nc_ht=scontent.fpnq7-3.fna&oh=00_AfDJ5lCxNWDSBEGU39KLjABcNin_ZgdhizPWRHS3qbvrDw&oe=63D66393',
                  fit: BoxFit.cover,
                  width: 80,
                ),
                const SizedBox(
                               height: 10, //<-- SEE HERE
                             ),
                             Image.network(
                  'https://erpnext.com/files/erpnext-logo-blue-v2.png',
                  fit: BoxFit.cover,
                  width: 120,
                  
                ),
                             const SizedBox(
                               height: 40, //<-- SEE HERE
                             ),
                             TextField(
                               style: const TextStyle(color: Colors.black),
                             
                               
                               controller:curlController,
                               decoration: InputDecoration(

                                   fillColor: Colors.grey.shade100,
                                   filled: true,
                                   prefixIcon: const Icon(Icons.add_link), 
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
                                   prefixIcon: const Icon(Icons.email_outlined), 
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
                                   prefixIcon: const Icon(Icons.password), 
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
                            child: ElevatedButton.icon(
                              
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
                                             String usrnm=loginStatus.toString();
                                             usrnm=usrnm.substring(55);
                                             usernm = usrnm.replaceAll(RegExp('[^A-Za-z]'), '');
                                             //print(usernm);
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
  
  label: Text('Login',style:TextStyle(fontSize: 20)), 
  icon: Icon( // <-- Icon
    Icons.login_rounded,
    size: 30.0,
  ),
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