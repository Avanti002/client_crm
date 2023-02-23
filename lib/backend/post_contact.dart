import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quantbit_crm/accessToken.dart' as at;

String accessToken = at.tokenAccess;

void postContact(String? firstname, String? lastname, String? companyname,
    String? emailid, String? mobileno) async {
  var headers = {
    'Authorization': '$accessToken',
    'Content-Type': 'text/plain',
    'Cookie':
        'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
  };
  var request = http.Request(
      'POST', Uri.parse('https://demo.erpdata.in/api/resource/Contact'));
  request.body =
      '''{\r\n      "first_name": "${firstname}",\r\n      "last_name": "${lastname}",\r\n      "company_name": "${companyname}",\r\n      "phone_nos": [\r\n        {\r\n          "phone": "${mobileno}"\r\n        }\r\n      ],\r\n      "email_ids": [\r\n        {\r\n          "email_id": "${emailid}"\r\n        }\r\n      ]\r\n    }''';

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(emailid);
    print(mobileno);
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
