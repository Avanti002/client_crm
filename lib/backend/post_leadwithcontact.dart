import 'package:http/http.dart' as http;
import 'package:quantbit_crm/accessToken.dart' as at;
import 'package:quantbit_crm/create/create_leadwithcontact.dart' as se;

String accessToken = at.tokenAccess;
void postleadwithcontact(
  String? companyname,
  String? lastname,
  String? leadstatus,
  String? emailid,
  String? city,
  String? state,
) async {
  var headers = {
    'Authorization': '$accessToken',
    'Content-Type': 'text/plain',
    'Cookie':
        'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
  };
  var request = http.Request(
      'POST', Uri.parse('https://demo.erpdata.in/api/resource/Lead'));
  request.body =
      '''{"first_name":"${se.name}","last_name": "$lastname","mobile_no": "${se.num}","status": "$leadstatus","email_id": "$emailid","company_name":"$companyname","city": "$city","state":"$state"}''';
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
