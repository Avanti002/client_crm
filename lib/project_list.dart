import 'package:flutter/material.dart';

import 'package:quantbit_crm/update_lead.dart';
import 'package:quantbit_crm/app_drawer.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quantbit_crm/login.dart' as login;

import 'package:quantbit_crm/home.dart' as home;
import 'package:quantbit_crm/update_lead.dart' as api;
import 'package:quantbit_crm/accessToken.dart' as at;
import 'package:quantbit_crm/create/create_opportunity.dart' as temp;

String accessToken = at.tokenAccess;
String curl = login.custUrl;
List plst = [];
String company_name = "";

String? _myState;

Future<List<Data>> fetchCNameList() async {
  List<Data> list = [];
  var httpsUri = Uri(
      scheme: 'https',
      host: 'demo.erpdata.in',
      path: '/api/resource/Project',
      query: 'fields=["name"]');
  var res = await http.get(httpsUri, headers: {
    'Authorization': '$accessToken',
    'Cookie':
    'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
  });
  if (res.statusCode == 200) {
    plst = json.decode(res.body)["data"] as List;
    fetchCNameList();
  }
  return list;
}

// Future<Data> fetchCname() async {
//   var headers = {
//     'Authorization': 'token da8dde973368af3:f584b09f290bab9',
//     'Cookie':
//         'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
//   };
//   var request = http.Request('GET',
//       Uri.parse('https://demo.erpdata.in/api/resource/Opportunity%20Type'));

//   request.headers.addAll(headers);

//   http.StreamedResponse response = await request.send();

//   if (response.statusCode == 200) {
//     await response.stream.bytesToString().then((value) {
//       temp = value;
//       leadind = temp
//           .toString()
//           .substring(18)
//           .replaceAll(RegExp('[^A-Za-z0-9-  \t]'), '');
//     });
//   } else {
//     print(response.reasonPhrase);
//   }
//   return Data.fromJson(jsonDecode(request.body));
// }

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

class Test extends StatefulWidget {
  const Test({super.key});
  @override
  State<StatefulWidget> createState() {
    return TestState();
  }
}

class TestState extends State<Test> {
  @override
  void initState() {
    setState(() {
      fetchCNameList();
      //fetchLeadind1();
      // api.fetchLeadind();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        drawer: myDrawer(context),
        appBar: AppBar(title: const Text("tests"), actions: <Widget>[
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
        body: FutureBuilder(
          future: fetchCNameList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return DropdownButtonFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person_outline_outlined),
                  labelText: 'Select Project',
                ),
                value: _myState,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: plst.map((items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items['name']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _myState = value as String?;
                    fetchCNameList();
                  });
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
