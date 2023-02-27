import 'package:http/http.dart' as http;
import 'package:quantbit_crm/accessToken.dart' as at;
import 'package:quantbit_crm/create/create_opportunity.dart' as toc;

String accessToken = at.tokenAccess;
void postoppo(String? opportunity_type, String? sales_stage, String? status1,
    String? probability) async {
  var headers = {
    'Authorization': '$accessToken',
    'Content-Type': 'text/plain',
    'Cookie':
        'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
  };
  var request = http.Request('POST',
      Uri.parse('https://mobilecrm.erpdata.in/api/resource/Opportunity'));
  request.body =
      '''{\r\n    "opportunity_from": "Lead","party_name":"${toc.temp1}",\r\n    "opportunity_type": "${opportunity_type}",\r\n    "sales_stage": "${sales_stage}",\r\n    "status": "${status1}",\r\n    "probability": "${probability}"\r\n\r\n\r\n\r\n}''';

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
