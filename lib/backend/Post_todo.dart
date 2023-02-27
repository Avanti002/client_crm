import 'package:http/http.dart' as http;
import 'package:quantbit_crm/accessToken.dart' as at;

import '../display_task.dart';

String accessToken = at.tokenAccess;
void posttodo() async {
  var headers = {
    'Authorization': '$accessToken',
    'Content-Type': 'text/plain',
    'Cookie':
        'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
  };
  var request = http.Request(
      'POST', Uri.parse('https://mobilecrm.erpdata.in/api/resource/ToDo'));
  request.body =
      '''{"allocated_to":"","completed_by": "fhfuhguthgu","priority": "$priority"}''';
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
