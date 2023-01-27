import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:quantbit_crm/lead.dart.';
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
var httpsUri = Uri(
    scheme: 'https',
    host: 'demo.erpdata.in',
    path: '/api/resource/User');

String link="https://demo.erpdata.in/api/resource/User";
var res = await http
.get(httpsUri,headers: {
  'Authorization': 'token da8dde973368af3:f584b09f290bab9',
  'Cookie': 'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
});

if (res.statusCode == 200) {
var obj=json.decode(res.body);
var rest=obj["data"] as List;

//print(rest);

for (var element in rest) {
  print(element);
}
list=rest.map<Data>((json)=>Data.fromJson(json)).toList();
lst=list;
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

class index extends StatefulWidget {
  const index({super.key});
  @override
  State<StatefulWidget> createState() {
    return indexState();
  }
}

class indexState extends State<index> {
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
            title: Text("Leads"),
            leading: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NavBar()),
                );
              },
              child: Icon(
                Icons.menu,
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.search,
                    size: 26.0,
                  ),
                ),
              ),
            ]),
        body: ListView.builder(itemCount: lst.length,itemBuilder: ((context, index) {
          return Text(lst[index]);
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
                MaterialPageRoute(builder: (context) => Mpp()),
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
