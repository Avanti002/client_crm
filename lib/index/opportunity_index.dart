import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:quantbit_crm/app_drawer.dart';
import 'package:quantbit_crm/create/create_opportunity.dart';
import 'package:quantbit_crm/display_opportunity.dart';
import 'package:quantbit_crm/login.dart' as login;
import 'package:quantbit_crm/accessToken.dart' as at;
import 'package:http/http.dart' as http;
import 'dart:convert';
String accessToken=at.tokenAccess;
String curl=login.custUrl;
int _selectedIndex = 0;
List lst=[];
String next="";
String oppoind="";
String tech="";
Future<List<Data>> fetchOppolist() async {
  List<Data> list=[];
  var httpsUri = Uri(scheme: 'https',host: '$curl',path: '/api/resource/Opportunity',query:'fields=["title"]');
  var res = await http
      .get(httpsUri,headers: {
    'Authorization': '$accessToken',
    'Cookie': 'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
  });
  if (res.statusCode == 200) {
    lst=json.decode(res.body)["data"] as List;
    fetchOppolist();
// var obj=json.decode(res.body);
// var rest=obj["data"] as List;
// lst=rest;
  }
  return list;
}
Future<Data> fetchOpponame() async {
  var headers = {
    'Authorization': 'token da8dde973368af3:f584b09f290bab9',
    'Cookie': 'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
  };
  var request = http.Request('GET', Uri.parse('https://demo.erpdata.in/api/resource/Opportunity?filters=[["title","=","$tech"]]'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    await response.stream.bytesToString().then((value) {

      next=value;
     // print(next);

      oppoind=next.toString().substring(18).replaceAll(RegExp('[^A-Za-z0-9-  \t]'), '');
     print(oppoind);
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

class Opportunityindex extends StatefulWidget {
  const Opportunityindex({super.key, required this.title});
  final String title;

  @override
  State<Opportunityindex> createState() => _Opportunityindex();
}

class _Opportunityindex extends State<Opportunityindex> {
  @override
  void initState() {
    setState(() {fetchOppolist();
      //gpt.fetchContactind();
    });
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: myDrawer(context),
        appBar: AppBar(
            title: Text(widget.title),

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
        body: ListView.builder(itemCount: lst.length,itemBuilder: ((context,position) {
          return Card(
            child: ListTile(title: Text((lst[position].toString()).substring(8).replaceAll(RegExp('[^A-Za-z  \t]'), '')),
                selected: position == _selectedIndex,onTap: () {
                  setState(() {

                    _selectedIndex = position;
                    tech=(lst[position].toString()).substring(8).replaceAll(RegExp('[^A-Za-z  \t]'), '');
                    fetchOpponame();
                   print(tech);
                  }
                  );
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>DisplayOppo(title: ''),)
                  );
                }),

          );
        })),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.add_event,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.arrow_circle_down_rounded,
                  color: Colors.white),
              label: 'Import from Address Book',
              backgroundColor: Colors.blue,
              onTap: () {},
            ),
            SpeedDialChild(
              child: const Icon(Icons.person_add, color: Colors.white),
              label: 'Add Account',
              backgroundColor: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Opportunity(
                        title: '',
                      )),
                );
              },
            ),
          ],
        ));
  }
}