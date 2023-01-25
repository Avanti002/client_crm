import 'package:http/http.dart' as http;
import 'package:quantbit_crm/lead.dart';


void postlead(
    String? companyname,
    String? firstname,
    String? lastname,
    String? mobileno,
    String? leadstatus,
    String? emailid,
    String? city,
    String? state,
    ) async {
  var headers = {
    'Authorization': 'token da8dde973368af3:f584b09f290bab9',
    'Content-Type': 'text/plain',
    'Cookie':
    'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
  };
  var request = http.Request(
      'POST', Uri.parse('https://demo.erpdata.in/api/resource/Lead'));
  request.body =
  '''{"first_name":"$firstname","last_name": "$lastname","mobile_no": "$mobileno","status": "$leadstatus","email_id": "$emailid","company_name":"$companyname","city": "$city","state":"$state"}''';
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}