import 'package:flutter/material.dart';

import 'package:quantbit_crm/update_lead.dart';
import 'package:quantbit_crm/app_drawer.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quantbit_crm/login.dart' as login;

import 'package:quantbit_crm/home.dart' as home;
import 'package:quantbit_crm/update_lead.dart' as api;
import 'package:quantbit_crm/accessToken.dart' as at;

String accessToken = at.tokenAccess;
String curl = login.custUrl;
List lst1 = [];

String? _myState;

Future<List<Data>> fetchCNameList() async {
  List<Data> list = [];
  var httpsUri = Uri(
      scheme: 'https',
      host: 'demo.erpdata.in',
      path: '/api/resource/Sales%20Stage',
      query: 'fields=["name"]');
  var res = await http.get(httpsUri, headers: {
    'Authorization': '$accessToken',
    'Cookie':
        'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
  });
  if (res.statusCode == 200) {
    lst1 = json.decode(res.body)["data"] as List;
    fetchCNameList();
    print(lst1);
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
                  labelText: 'Sales Stage',
                ),
                value: _myState,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: lst1.map((items) {
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
              // DropdownButton<String>(
              //     items: lst1.map((item) {
              //       return DropdownMenuItem<String>(
              //         value: _myState,
              //         child: Text(item['name']),
              //       );
              //     }).toList(),
              //     hint: const Text('Opportunity Type'),
              //     onChanged: (String? value) {
              //       setState(() {
              //         _myState = value;
              //         fetchCNameList();
              //       });
              //     });
            } else {
              return const CircularProgressIndicator();
            }
          },
          // DropdownButtonHideUnderline(
          //   child: ButtonTheme(
          //     alignedDropdown: true,
          //     child: DropdownButton<String>(
          //       value: _myState,
          //       iconSize: 30,
          //       icon: (null),
          //       style: const TextStyle(
          //         color: Colors.black54,
          //         fontSize: 16,
          //       ),
          //       hint: const Text('Opportunity Type'),
          //       onChanged: (String? newValue) {
          //         setState(() {
          //           _myState = newValue;
          //           fetchCNameList();
          //         });
          //       },
          //       items: lst1.map((item) {
          //             return DropdownMenuItem(
          //               value: item['id'].toString(),
          //               child: Text(item['name']),
          //             );
          //           }).toList()
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}
