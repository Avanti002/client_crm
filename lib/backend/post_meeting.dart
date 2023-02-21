import 'package:http/http.dart' as http;
import 'package:quantbit_crm/accessToken.dart' as at;
import 'package:quantbit_crm/create/create_meeting.dart' as met;

String accessToken = at.tokenAccess;
String xyz = met.start;

void postMeeting(String? subject, String? starts_on, DateTime? ends_on,
    String? description, String? meeting_link) async {
  var headers = {
    'Authorization': '$accessToken',
    'Content-Type': 'text/plain',
    'Cookie':
        'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
  };
  var request = http.Request(
      'POST', Uri.parse('https://demo.erpdata.in/api/resource/Event'));
  request.body =
      '''{\r\n    \r\n    "subject": "${subject}",\r\n    "starts_on": "${met.start}",\r\n    "ends_on": "${met.end}",\r\n    "event_type": "Private"\r\n,\r\n    "description": "${description}"\r\n,\r\n    "meeting_link": "${meeting_link}"\r\n}''';

  print(met.end);
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
