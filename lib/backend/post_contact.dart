import 'package:http/http.dart' as http;
import 'package:quantbit_crm/accessToken.dart' as at;

String accessToken=at.tokenAccess;
void postContact(String? firstname, String? lastname, String? accountname,
    String? emailid, String? mobileno) async {
  var headers = {
    'Authorization': '$accessToken',
    'Content-Type': 'text/plain',
    'Cookie':
        'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
  };
  var request = http.Request(
      'POST', Uri.parse('https://demo.erpdata.in/api/resource/contact1'));
  request.body =
      '''{"first_name": "$firstname",\n"last_name": "$lastname" ,\n"account_name":"$accountname",\n"email_id":"$emailid",\n"mobile_no":"$mobileno"\n}''';
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
