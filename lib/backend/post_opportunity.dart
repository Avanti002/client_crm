import 'package:http/http.dart' as http;
import 'package:quantbit_crm/accessToken.dart' as at;

String accessToken = at.tokenAccess;
void postoppo() async {
  var headers = {
    'Authorization': '$accessToken',
    'Content-Type': 'text/plain',
    'Cookie':
        'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
  };
  var request = http.Request(
      'POST', Uri.parse('https://demo.erpdata.in/api/resource/Opportunity'));
  request.body =
      '''{\r\n    "opportunity_from": "Lead","party_name":"CRM-LEAD-2023-00060",\r\n    "opportunity_type": "Sales",\r\n    "sales_stage": "Prospecting",\r\n    "status": "Open",\r\n    "probability": "100.0"\r\n\r\n\r\n\r\n}''';

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
