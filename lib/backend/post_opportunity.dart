import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:quantbit_crm/accessToken.dart' as at;

String accessToken = at.tokenAccess;

void postOpportunity() async {
  var headers = {
    'Authorization': '$accessToken',
    'Content-Type': 'text/plain',
    'Cookie':
        'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
  };
  var request = http.Request(
      'POST', Uri.parse('https://demo.erpdata.in/api/resource/Opportunity'));
  request.body =
      '''{"opportunity_from": "Lead",\n"party": "CRM-LEAD-2023-00049" ,\n"opportunity_type":"Sales"}''';
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
