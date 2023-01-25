import 'package:http/http.dart' as http;

Future<String?> getD(
  String? name,
) async {
  var headers = {
    'Authorization': 'token 94133f5eab07810:5cf8dc02b0fb6ec',
    'Content-Type': 'text/plain',
    'Cookie':
        'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
  };
  var request = http.Request(
      'GET', Uri.parse('https://demo.erpdata.in/api/resource/contact1'));
  request.body = '''{"name": "$name"\n}''';
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    return response.stream.bytesToString();
  } else {
    return response.reasonPhrase;
  }
}
