// ignore_for_file: prefer_typing_uninitialized_variables, avoid_types_as_parameter_names, library_private_types_in_public_api
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'home.dart';
import 'package:quantbit_crm/accessToken.dart' as at;

var loginStatus;
String sCode="";
String usernm="";
String emailid="";
String password="";
String mobaccess="0";
String accessStatus="";
String custUrl="";
String accessToken=at.tokenAccess;

class MyLogin extends StatefulWidget {
const MyLogin({Key? key}) : super(key: key);
  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  bool _passwordVisible=false;
   @override
void initState() {
  setState(() {usrMobAccess();});
  _passwordVisible = false;
  super.initState();
}
  TextEditingController curlController = TextEditingController()..text="demo.erpdata.in";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void usrMobAccess() async { 
    try
    {
      String email=emailController.text;
      String cUrl=curlController.text;
      var headers = {
      'Authorization': '$accessToken',
      'Cookie': 'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
      };
      var request = http.Request('GET', Uri.parse('https://$cUrl/api/resource/User?filters=[["name","=","$email"]]&fields=["mob_access"]'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        await response.stream.bytesToString().then((value) {
        mobaccess=value.toString();
        usrLogin(curlController.text,emailController.text,passwordController.text);
        if(mobaccess.substring(23,24)=="1")
        { 
          accessStatus="Granted";
        }
        else
        {
          accessStatus="Denied";
        }
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
  void usrLogin(String curl,String email,String pass) async { 
    try
    {
      emailid=email;
      password=pass;
      custUrl=curl;

    var request =http.Request('GET', Uri.parse('http://$curl/api/method/login?usr=$email&pwd=$pass'));
    http.StreamedResponse response = await request.send(); 
    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((value) {
      loginStatus=value;
      usrLogin(curl,email,pass);
      //usrMobAccess();
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
      body: Container(
       // decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/login.png"))),
        child: Stack(
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
                  'https://precog.com/wp-content/uploads/2021/07/ERP-Next-logo.png',
                  fit: BoxFit.cover,
                  width: 170,
                ),
                
                               const SizedBox(
                                 height: 20, //<-- SEE HERE
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
                             TextFormField(
                               style: const TextStyle(),
                               obscureText: !_passwordVisible,
                               controller: passwordController,
                               decoration: InputDecoration(
                                   prefixIcon: const Icon(Icons.password), 
                                   suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                        color: Theme.of(context).primaryColorDark,
                                        ),
                                      onPressed: () {
                                        
                                        setState(() {
                                            _passwordVisible = !_passwordVisible;
                                        });
                                      }),
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
    if(emailController.text!="" && passwordController.text!="")
    {
                            usrMobAccess();
                             Timer(const Duration(seconds: 4),() {
                               sCode=loginStatus.toString();
                             });  
                             Timer(const Duration(seconds: 4),() {
                               if(sCode!="null"){
                                  if(accessStatus=="Granted")
                                  {
                                      if(sCode.substring(12,21)=="Logged In")
                                      {
                                                    Navigator.push(
                                                    context,
                                                      MaterialPageRoute(builder: (context) => Home(),)
                                                    );
                                                    String usrnm=loginStatus.toString();
                                                    usrnm=usrnm.substring(55);
                                                    usernm = usrnm.replaceAll(RegExp('[^A-Za-z  \t]'), '');
                                                  
                                      }
                                      else
                                      {
                                                    if (kDebugMode) {
                                                      print("wrong");
                                                    }
                                      }
                                }
                                else
                                {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Access Denied !')));
                                }
                               }
                               else{
                                 ScaffoldMessenger.of(context).showSnackBar(
                                 const SnackBar(content: Text('Please Enter correct Username or Password !')));
                               }
                             });
    }
    else
    {
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Email or Password Field Should not be Empty !')));
    }
  },
  label: Text('Login',style:TextStyle(fontSize: 20)), 
  icon: Icon( // <-- Icon
    Icons.login_rounded,
    size: 30.0,
  ),
),
  ),
  ElevatedButton.icon(                          
  onPressed: () {
     Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home(),)
      );                                      
  },
  label: Text('Bypass',style:TextStyle(fontSize: 20)), 
  icon: Icon( // <-- Icon
    Icons.login_rounded,
    size: 30.0,
  ),
),
    ],
      ),
        ),
          ],
            ), 
              ),
                ],
                  ),
                  ),
                    );
}
}