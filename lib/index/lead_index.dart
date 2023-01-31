import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:quantbit_crm/app_drawer.dart';
import 'package:quantbit_crm/create/create_lead.dart.';
import 'package:quantbit_crm/picker/pick_lead.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quantbit_crm/login.dart' as login;

String curl=login.custUrl;
List lst=[];

Future<List<Data>> fetchData() async {
List<Data> list=[];
var httpsUri = Uri(scheme: 'https',host: '$curl',path: '/api/resource/Lead',query:'fields=["company_name"]');
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
  final String company_name;
  final String data;

  const Data({
    required this.data,
    required this.company_name,
    
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      data: json['data'],
      company_name: json['company_name'],
    );
  }
}

class Leadindex extends StatefulWidget {
  const Leadindex({super.key});
  @override
  State<StatefulWidget> createState() {
    return LeadindexState();
  }
}

class LeadindexState extends State<Leadindex> {
  @override
void initState() {
  setState(() {fetchData();});
  super.initState();
  
}
  int _selectedIndex = 0;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        drawer: myDrawer(context),
        appBar: AppBar(
            title: Text("Leads"),
            
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
            child: ListTile(title: Text((lst[position].toString()).substring(15).replaceAll(RegExp('[^A-Za-z  \t]'), ''
            
            )),selected: position == _selectedIndex,onTap: () {
            setState(() {
              _selectedIndex = position;
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    scrollable: true,
                    title: Text((lst[_selectedIndex].toString()).substring(15).replaceAll(RegExp('[^A-Za-z  \t]'), '')),
                     actions: [
                      ElevatedButton(
                          child: Text('Close'),
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ],
                  );
                });
         
               
            });}),
            
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
                MaterialPageRoute(builder: (context) => LeadPicker()),
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
                MaterialPageRoute(builder: (context) => CreateLead()),
              );
            },
          ),
        ]),
      ),
    );
  }
}
