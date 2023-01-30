import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:quantbit_crm/contact.dart';
import 'package:quantbit_crm/pick_contact.dart';
import 'package:quantbit_crm/side.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quantbit_crm/login.dart' as login;


String curl=login.custUrl;
List lst=[];

Future<List<Data>> fetchData() async {
List<Data> list=[];
var httpsUri = Uri(scheme: 'https',host: '$curl',path: '/api/resource/Contact',query:'fields=["name"]');
var res = await http
.get(httpsUri,headers: {
  'Authorization': 'token da8dde973368af3:f584b09f290bab9',
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
        appBar: AppBar(
            title: Text("Contacts"),
            leading: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NavBar()),
                );
              },
              child: const Icon(
                Icons.menu,
              ),
            ),
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
        body: ListView.builder(itemCount: lst.length,itemBuilder: ((context, position) {
          return Card(
            child: ListTile(title: Text((lst[position].toString()).substring(7).replaceAll(RegExp('[^A-Za-z]'), ''))),
            
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
                MaterialPageRoute(builder: (context) => Mp()),
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
                MaterialPageRoute(builder: (context) => Contacts(title: 'Create Contact',)),
              );
            },
          ),
        ]),
      ),
    );
  }
}
