import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:quantbit_crm/app_drawer.dart';
import 'package:quantbit_crm/create/create_contact.dart';
import 'package:quantbit_crm/picker/pick_contact.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quantbit_crm/home.dart' as home;
import 'package:quantbit_crm/login.dart' as login;
import 'package:quantbit_crm/accessToken.dart' as at;
import 'package:quantbit_crm/display_contact.dart'as gpt;
import 'package:quantbit_crm/display_contact.dart';

String accessToken=at.tokenAccess;
String curl=login.custUrl;
List lst=[];
String name1="";
String contactind="";
String pqr="";

Future<List<Data>> fetchContactlist() async {
List<Data> list=[];
var httpsUri = Uri(scheme: 'https',host: '$curl',path: '/api/resource/Contact',query:'fields=["name"]');
var res = await http
.get(httpsUri,headers: {
  'Authorization': '$accessToken',
  'Cookie': 'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
});
if (res.statusCode == 200) {
  lst=json.decode(res.body)["data"] as List;
  fetchContactlist();
// var obj=json.decode(res.body);
// var rest=obj["data"] as List;
// lst=rest;
}
return list;
}
Future<Data> fetchContactname() async {
  var headers = {
    'Authorization': 'token da8dde973368af3:f584b09f290bab9',
    'Cookie': 'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
  };
  var request = http.Request('GET', Uri.parse('https://demo.erpdata.in/api/resource/Contact?filters=[["name","=","$name1"]]'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    await response.stream.bytesToString().then((value) {
      pqr=value;

      contactind=pqr.toString().substring(18).replaceAll(RegExp('[^A-Za-z0-9-  \t]'), '');
      print(contactind);
    });
  }
  else {
    print(response.reasonPhrase);
  }
  return Data.fromJson(jsonDecode(request.body));
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
  setState(() {fetchContactlist();
  gpt.fetchContactind();});
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
            child: ListTile(title: Text((lst[position].toString()).substring(7).replaceAll(RegExp('[^A-Za-z  \t]'), '')),
    selected: position == _selectedIndex,onTap: () {
    setState(() {

    _selectedIndex = position;
    name1=(lst[position].toString()).substring(7).replaceAll(RegExp('[^A-Za-z  \t]'), '');
    fetchContactname();
    print(name1);
    }
    );
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>DisplayContact(title: ''),)
    );
                }),

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
