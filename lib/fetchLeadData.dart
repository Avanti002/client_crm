import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quantbit_crm/test.dart' as tst;

var temp;

var c_name=tst.cName;
String leadind="";
Future<Data> fetchData() async {
 var headers = {
  'Authorization': 'token da8dde973368af3:f584b09f290bab9',
  'Cookie': 'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
};
var request = http.Request('GET', Uri.parse('https://demo.erpdata.in/api/resource/Lead/CRM-LEAD-2023-00049'));

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
 await response.stream.bytesToString().then((value) {
  temp=value;
  leadind=temp;
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


class LeadData extends StatefulWidget {
  const LeadData({super.key});

  @override
  State<LeadData> createState() => _LeadDataState();
}

class _LeadDataState extends State<LeadData> {
  late Future<Data> futureData;


  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Data>(
            future: futureData,
            builder: (context,AsyncSnapshot<Data> snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.data.toString());
              } else if (snapshot.hasError) {
                return Text(temp.toString().substring(19));
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}