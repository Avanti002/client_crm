import 'package:flutter/material.dart';
import 'package:quantbit_crm/CallLog.dart';
import 'package:quantbit_crm/accessToken.dart';
import 'package:quantbit_crm/service_locator.dart';

import 'package:quantbit_crm/tokenTest.dart';
import 'package:quantbit_crm/login.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AccessToken(),
    );
  }
}
