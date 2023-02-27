import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:quantbit_crm/accessToken.dart' as at;
import 'package:quantbit_crm/create/create_task.dart' as task;

String accessToken = at.tokenAccess;
void sendData(String? subject, String? status, String? priority,
    String? task_weight, String? description) async {
  var headers = {
    'Authorization': '$accessToken',
    'Content-Type': 'text/plain',
    'Cookie':
        'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
  };
  var request = http.Request(
      'POST', Uri.parse('https://demo.erpdata.in/api/resource/Task'));
  request.body =
      //'''{"subject":"$subject","status":"$status","priority": "$priority","exp_start_date":"$exp_start_date"}''';
      '''{\r\n    "subject":"${subject}",\r\n    "project":"${task.temp1}",\r\n    "status":"${status}",\r\n    "priority":"${priority}",\r\n    "issue":"${task.Itemp1}",\r\n    "weight":"${task_weight}",\r\n    "type":"",\r\n    "parent_task":"",\r\n    "exp_start_date":"",\r\n    "progress":"",\r\n    "description":"${description}"\r\n   \r\n\r\n}''';
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(task.TTtemp1);
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
