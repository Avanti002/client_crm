import 'dart:io';

import 'package:http/http.dart' as http;

void sendData(String? subject,String? status,String? priority,DateTime? exp_start_date) async {
  var headers = {
    'Authorization': 'token da8dde973368af3:f584b09f290bab9',
    'Content-Type': 'text/plain',
    'Cookie': 'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
  };
  var request = http.Request(
      'POST', Uri.parse('https://demo.erpdata.in/api/resource/Task'));
  request.body = '''{"subject":"$subject","status":"$status","priority": "$priority","exp_start_date":"$exp_start_date"}''';
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }
}
