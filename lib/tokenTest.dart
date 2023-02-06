import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var api_key="";
var api_secret="";
var loggedUser="";

Future<Data> fetchApiKey() async {
  var headers = {
    'Authorization': 'token da8dde973368af3:f584b09f290bab9',
    'Cookie': 'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
  };
  var request = http.Request('GET', Uri.parse('https://demo.erpdata.in/api/resource/User?filters=[["name","=","abhishek.chougule@erpdata.in"]]&fields=["api_key"]'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    await response.stream.bytesToString().then((value) {
      api_key=value;
      api_key=api_key.substring(21).replaceAll(RegExp('[^A-Za-z0-9  \t]'), '');
    });
  }
  else {
    print(response.reasonPhrase);
  }
  return Data.fromJson(jsonDecode(request.body));
}
Future<Data> fetchApiSecret() async {
  var headers = {
    'Authorization': 'token da8dde973368af3:f584b09f290bab9',
    'Cookie': 'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
  };
  var request = http.Request('POST', Uri.parse('https://demo.erpdata.in/api/method/frappe.core.doctype.user.user.generate_keys?user=abhishek.chougule@erpdata.in'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    await response.stream.bytesToString().then((value) {
      api_secret=value;
      api_secret=api_secret.substring(26).replaceAll(RegExp('[^A-Za-z0-9  \t]'), '');
    });
  }
  else {
    print(response.reasonPhrase);
  }
  return Data.fromJson(jsonDecode(request.body));
}

// Future<Data> fetchLoggedUser() async {
//   var token_secret=await 'token $api_key:$api_secret';
//   var headers = {
//     'Authorization': token_secret,
//     'Cookie': 'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
//   };
//   var request = http.Request('POST', Uri.parse('https://demo.erpdata.in/api/method/frappe.auth.get_logged_user'));

//   request.headers.addAll(headers);

//   http.StreamedResponse response = await request.send();

//   if (response.statusCode == 200) {
//     await response.stream.bytesToString().then((value) {
//       loggedUser=value;
//       //api_secret=api_secret.substring(26).replaceAll(RegExp('[^A-Za-z0-9  \t]'), '');
//       //print(api_secret);
//     });
//   }
//   else {
//     print(response.reasonPhrase);
//     fetchLoggedUser();
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


class TokenTest extends StatefulWidget {
  const TokenTest({super.key});

  @override
  State<TokenTest> createState() => _TokenTestState();
}

class _TokenTestState extends State<TokenTest> {

  @override
  void initState() {
    fetchApiKey();
    fetchApiSecret();
    //fetchLoggedUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(  
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () { Navigator.pop(context); },),
          title: const Text('Test'),
        ),
        body: Center(
          child: Text('token $api_key:$api_secret'),
          
        ),
      ),
    );
  }
}