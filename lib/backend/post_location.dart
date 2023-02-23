import 'package:http/http.dart' as http;
import 'package:quantbit_crm/accessToken.dart' as at;

String accessToken = at.tokenAccess;
void postlocation(
    String inlat,
    String inlong,
    String inaddress,
    String inTime,
    String inDate,
    String inRunning,
    String outlat,
    String outlong,
    String outaddress,
    String outTime,
    String outDate,
    String outRunning,
    String totalkm,
    String totalHours) async {
  var headers = {
    'Authorization': 'token 2de95e9c100d19c:6cde1fa98f2c82e',
    'Content-Type': 'text/plain',
    'Cookie':
        'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
  };
  var request = http.Request('POST',
      Uri.parse('http://swtechnotest.erpdata.in/api/resource/Geo%20tagging'));
  request.body =
      '''{"inaddress":"$inaddress","indate":"$inDate","intime":"$inTime","inlat":"$inlat","inlong":"$inlong","inrunning":"$inRunning","total_km":"$totalkm","total_work":"$totalHours"}''';
// '''{"indate"="$inDate","intime"="$inTime","inlat"="$inlat","inlong"="$inlong","inaddress"="$inaddress","inrunning"="$inRunning","outdate"="$outDate","outtime"="$outTime","outlat"="$outlat","outlong"="$outlong","outaddress"="$outaddress","outrunning"="$outRunning"}''';
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
