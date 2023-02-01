import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quantbit_crm/index/deal_index.dart';
import 'package:quantbit_crm/index/lead_index.dart' as li;

var temp;
String cName=li.companyName;
Future<Data> fetchData() async {
 var headers = {
  'Authorization': 'token da8dde973368af3:f584b09f290bab9',
  'Cookie': 'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
};
var request = http.Request('GET', Uri.parse('https://demo.erpdata.in/api/resource/Lead?filters=[["company_name","=","$cName"]]'));

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
 await response.stream.bytesToString().then((value) {
  temp=value;
  cName=li.companyName;
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


class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late Future<Data> futureData;


  @override
  void initState() {
    super.initState();
    futureData = fetchData();
    cName=li.companyName;
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
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () { Navigator.pop(context); },),
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Data>(
            future: futureData,
            builder: (context,AsyncSnapshot<Data> snapshot) {
              if (snapshot.hasData) {
                Timer(Duration(seconds: 3), () { 
                  setState(() {
                        cName=li.companyName;
                  });
                  }); 
                return Text(snapshot.data!.data.toString());
              } else if (snapshot.hasError) {
                
                return Text(temp);
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