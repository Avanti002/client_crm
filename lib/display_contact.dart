import 'package:flutter/material.dart';
import 'package:quantbit_crm/app_drawer.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:quantbit_crm/index/contact_index.dart' as contact;
import 'package:quantbit_crm/index/contact_index.dart';
import 'package:quantbit_crm/accessToken.dart' as at;
import 'package:quantbit_crm/service_locator.dart';
import 'package:quantbit_crm/home.dart';
import 'package:quantbit_crm/update_lead.dart';
import 'package:url_launcher/url_launcher.dart';

String accessToken=at.tokenAccess;
String first_name="";

String email_id="";
String last_name="";

String mobile_no="";
String company_name="";
Future<List<Data>> fetchContactind() async {
  List<Data> list=[];
  var httpsUri = Uri(scheme: 'https',host: 'demo.erpdata.in',path: '/api/resource/Contact/${contact.contactind}');
  var res = await http
      .get(httpsUri,headers: {
    'Authorization': '$accessToken',
    'Cookie': 'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
  });
  if (res.statusCode == 200) {
    //name==json.decode(res.body)["data"]["name"];
    first_name=(json.decode(res.body)["data"]["first_name"]).toString();
    last_name=(json.decode(res.body)["data"]["last_name"]).toString();
    company_name=(json.decode(res.body)["data"]["company_name"]).toString();
    email_id=(json.decode(res.body)["data"]["email_id"]).toString();

    mobile_no=(json.decode(res.body)["data"]["mobile_no"]).toString();

    fetchContactind();
  }
  return list;
}


class Data {
  final String name;
  final String data;

  const Data({
    required this.data,
    required this.name,

  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      data: json['data'],
      name: json['name'],
    );
  }
}



class DisplayContact extends StatefulWidget {
  const DisplayContact({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<DisplayContact> createState() => _DisplayContactState();
}

class _DisplayContactState extends State<DisplayContact> {
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();

  TextEditingController companyNamecontroller = TextEditingController()
    ..text = company_name;
  TextEditingController firstnamecontroller = TextEditingController()
    ..text = first_name;
  TextEditingController emailidcontroller = TextEditingController()
    ..text = email_id;
  TextEditingController lastnamecontroller = TextEditingController()
    ..text = last_name;

  TextEditingController mobilenocontroller = TextEditingController()
    ..text = mobile_no;

  @override
  void initState() {
    setState(() {
      contact.fetchContactname();
      fetchContactind();
    });
    super.initState();
  }

  String? firstname;
  String? lastname;
  String? companyname;
  String? emailid;
  String? mobileno;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Update Lead',
        home: Scaffold(
        drawer: myDrawer(context),
      appBar: AppBar(
          title: Text(' display contact'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.check,
                  size: 26.0,
                ),
              ),
            ),
          ]),
      body: Padding(padding: EdgeInsets.all(20),
        child:
        Column(
          children: <Widget>[

            TextFormField(
                controller: firstnamecontroller,
                decoration: const InputDecoration(
                    labelText: 'First Name', icon: Icon(Icons.person)),
                onChanged: (value) {
                  setState(() {
                    firstname = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                }),
            TextFormField(
                controller: lastnamecontroller,
                decoration: const InputDecoration(
                    labelText: 'Last Name', icon: Icon(Icons.person)),
                onChanged: (value) {
                  setState(() {
                    lastname = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                }),
            TextFormField(
                controller: companyNamecontroller,
                decoration: const InputDecoration(
                    labelText: 'Company Name',
                    icon: Icon(Icons.account_box)),
                onChanged: (value) {
                  setState(() {
                    companyname = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                }),
            TextFormField(
                controller: emailidcontroller,
                decoration: const InputDecoration(
                    labelText: 'Email Id', icon: Icon(Icons.email)),
                onChanged: (value) {
                  setState(() {
                    emailid = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                }),
            TextFormField(
                controller: mobilenocontroller,
                decoration: const InputDecoration(
                    labelText: 'Mobile No.',
                    icon: Icon(Icons.phone_android_sharp)),
                onChanged: (value) {
                  setState(() {
                    mobileno = mobileno;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some number';
                  }
                  return null;
                }),
          ],
        ),
      ),
          floatingActionButton: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(onPressed: (){whatsapp(mobile_no);},child:Image.network('https://cdn-icons-png.flaticon.com/512/4494/4494494.png')),
                SizedBox(width: 30,),
                FloatingActionButton(onPressed: (){_service.call(mobile_no);},child:Image.network('https://cdn-icons-png.flaticon.com/512/724/724664.png')),
                SizedBox(width: 30,),
                FloatingActionButton(onPressed: (){_service.sendSms(mobile_no);},child:Image.network('https://cdn-icons-png.flaticon.com/512/234/234129.png')),
                SizedBox(width: 30,),
                FloatingActionButton(onPressed: (){ _service.sendEmail(email_id);},child:Image.network('https://cdn-icons-png.flaticon.com/512/2913/2913990.png')),
              ],),
          ),
        )
    );
  }
}