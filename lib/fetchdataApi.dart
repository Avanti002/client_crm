// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: prefer_typing_uninitialized_variables
var temp;
Future<Data> fetchData() async {
 var headers = {
  'Authorization': 'token da8dde973368af3:f584b09f290bab9',
  'Cookie': 'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
};
var request = http.Request('GET', Uri.parse('https://demo.erpdata.in/api/resource/User/'));

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
 await response.stream.bytesToString().then((value) {
  temp=value;
                  if (kDebugMode) {
                    print(value);
                  }
                  });
  //print(await response.stream.bytesToString());
 
}
else {
  if (kDebugMode) {
    print(response.reasonPhrase);
  }
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


class MyApp1 extends StatefulWidget {
  const MyApp1({super.key});

  @override
  State<MyApp1> createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> {
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