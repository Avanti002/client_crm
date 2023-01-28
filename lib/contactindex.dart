import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:quantbit_crm/lead.dart.';
import 'package:quantbit_crm/pick_contact.dart';
import 'package:quantbit_crm/pick_lead.dart';
import 'package:quantbit_crm/side.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quantbit_crm/login.dart' as login;

var temp;
var object;
List lst=[];

Future<List<Data>> fetchData() async {
  List<Data> list=[];
 var headers = {
  'Authorization': 'token da8dde973368af3:f584b09f290bab9',
  'Cookie': 'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
};

var email=login.emailid;
var httpsUri = Uri(scheme: 'https',host: 'demo.erpdata.in',path: '/api/resource/Contact',query:'fields=["name"]');

String link="https://demo.erpdata.in/api/resource/Lead";
var res = await http
.get(httpsUri,headers: {
  'Authorization': 'token da8dde973368af3:f584b09f290bab9',
  'Cookie': 'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
});


if (res.statusCode == 200) {
var obj=json.decode(res.body);
var rest=obj["data"] as List;
for (var element in rest) {
  lst.add(element);
}
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

class conindex extends StatefulWidget {
  const conindex({super.key});
  @override
  State<StatefulWidget> createState() {
    return cindexState();
  }
}

class cindexState extends State<conindex> {
  @override
void initState() {
  super.initState();
  fetchData();
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
            child: ListTile(title: Text('Contact Name : '+(lst[position].toString()).substring(7).replaceAll(RegExp('[^A-Za-z]'), ''))),
            
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
            label: 'New Lead',
            backgroundColor: Colors.blue,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FormScreen()),
              );
            },
          ),
        ]),
      ),
    );
  }
}
