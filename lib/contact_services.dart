import 'package:flutter/material.dart';

import 'package:quantbit_crm/service_locator.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactServices extends StatefulWidget {
  const ContactServices({super.key});

  @override
  ContactServicesState createState() => ContactServicesState();
}

class ContactServicesState extends State<ContactServices> {
  
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();

  final String number = "8308020899";
  final String email = "sohampawar7575@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('contact Services'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ElevatedButton(
              child: Text(
                "call",
              ),
              onPressed: () => _service.call(number),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: Text(
                "message",
              ),
              onPressed: () => _service.sendSms(number),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: Text(
                "email",
              ),
              onPressed: () => _service.sendEmail(email),
            ),
          ],
        ),
      ),
    );
  }
}


class CallsAndMessagesService {
  Future<void> call(String number) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: number,
    );
    await launchUrl(launchUri);
  }

  Future<void> sendSms(String number) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: number,
    );
    await launchUrl(launchUri);
  }

  Future<void> sendEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: "mailto",
      path: email,
    );
    await launchUrl(launchUri);
  }
}