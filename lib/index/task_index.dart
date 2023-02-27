import 'package:flutter/material.dart';
import 'package:quantbit_crm/app_drawer.dart';
import 'package:quantbit_crm/create/create_task.dart';
import 'package:quantbit_crm/create/create_deal.dart';
import 'package:quantbit_crm/login.dart' as login;
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:quantbit_crm/accessToken.dart' as at;
import 'package:quantbit_crm/display_task.dart' as nm;
import 'package:quantbit_crm/display_task.dart';
import 'package:quantbit_crm/home.dart' as home;

String accessToken = at.tokenAccess;
String curl = login.custUrl;
List lst2 = [];
String nme = "";
String taskind = "";
String xyz = "";
int _selectedIndex = 0;
Future<List<Data>> fetchTasklist() async {
  List<Data> list = [];
  var httpsUri = Uri(
      scheme: 'https',
      host: '$curl',
      path: '/api/resource/Task',
      query: 'fields=["subject"]');
  var res = await http.get(httpsUri, headers: {
    'Authorization': '$accessToken',
    'Cookie':
        'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
  });
  if (res.statusCode == 200) {
    lst2 = json.decode(res.body)["data"] as List;
    fetchTasklist();
// var obj=json.decode(res.body);
// var rest=obj["data"] as List;
// lst=rest;
  }
  return list;
}

Future<Data> fetchTaskname() async {
  var headers = {
    'Authorization': 'token da8dde973368af3:f584b09f290bab9',
    'Cookie':
        'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
  };
  var request = http.Request(
      'GET',
      Uri.parse(
          'https://mobilecrm.erpdata.in/api/resource/Task?filters=[["subject","=","$nme"]]'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    await response.stream.bytesToString().then((value) {
      //print(value);
      xyz = value;

      taskind = xyz
          .toString()
          .substring(18)
          .replaceAll(RegExp('[^A-Za-z0-9-  \t]'), '');
      // print(xyz)
      print(taskind);
    });
  } else {
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

class Taskindex extends StatefulWidget {
  const Taskindex({super.key});
  @override
  State<StatefulWidget> createState() {
    return TaskindexState();
  }
}

class TaskindexState extends State<Taskindex> {
  @override
  void initState() {
    setState(() {
      fetchTasklist();
      nm.fetchTaskind();
    });
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
          drawer: myDrawer(context),
          appBar: AppBar(title: Text("Tasks"), actions: <Widget>[
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
          body: ListView.builder(
              itemCount: home.lst3.length,
              itemBuilder: ((context, position) {
                return Card(
                  child: ListTile(
                      title: Text((home.lst3[position].toString())
                          .substring(10)
                          .replaceAll(RegExp('[^A-Za-z-0-9-0-9 \t]'), '')),
                      selected: position == _selectedIndex,
                      onTap: () {
                        setState(() {
                          _selectedIndex = position;
                          nme = (home.lst3[position].toString())
                              .substring(10)
                              .replaceAll(RegExp('[^A-Za-z-0-9-0-9  \t]'), '');
                          fetchTaskname();
                          print(nme);
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DisplayTask(),
                            ));
                      }),
                );
              })),
          floatingActionButton: FloatingActionButton(
              elevation: 0.0,
              child: Icon(Icons.add),
              backgroundColor: Colors.blue,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateTask()),
                );
              })),

      //  child: Text('Hello World'),
    );
  }
}
