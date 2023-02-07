import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:quantbit_crm/app_drawer.dart';
import 'package:quantbit_crm/create/create_contact.dart';
import 'package:quantbit_crm/picker/pick_contact.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quantbit_crm/login.dart' as login;
import 'package:quantbit_crm/accessToken.dart' as at;

String accessToken=at.tokenAccess;
String curl=login.custUrl;
List lst=[];

Future<List<Data>> fetchData() async {
List<Data> list=[];
var httpsUri = Uri(scheme: 'https',host: '$curl',path: '/api/resource/Contact',query:'fields=["name"]');
var res = await http
.get(httpsUri,headers: {
  'Authorization': '$accessToken',
  'Cookie': 'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
});
if (res.statusCode == 200) {
var obj=json.decode(res.body);
var rest=obj["data"] as List;
lst=rest;
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

class Contactindex extends StatefulWidget {
  const Contactindex({super.key});
  @override
  State<StatefulWidget> createState() {
    return ContactindexState();
  }
}

class ContactindexState extends State<Contactindex> {
  @override
void initState() {
  setState(() {fetchData();});
  super.initState();
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        drawer: myDrawer(context),
        appBar: AppBar(
            title: Text("Contacts"),
            
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.search,
                    size: 26.0,
                  ),
                ),
              ),
            ]),
        body: ListView.builder(itemCount: lst.length,itemBuilder: ((context,position) {
          return Card(
            child: ListTile(title: Text((lst[position].toString()).substring(7).replaceAll(RegExp('[^A-Za-z  \t]'), ''))), 
          );
        })),
        floatingActionButton:
            SpeedDial(animatedIcon: AnimatedIcons.add_event, children: [
          SpeedDialChild(
            child: const Icon(Icons.arrow_circle_down_rounded,
                color: Colors.white),
            label: 'Import from Address Book',
            backgroundColor: Colors.blue,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactPicker()),
              );

            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.person_add, color: Colors.white),
            label: 'New Contact',
            backgroundColor: Colors.blue,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateContact(title: 'Create Contact',)),
              );
            },
          ),
        ]),
      ),
    );
  }
}
