import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';




class LeadPicker extends StatefulWidget{
  const LeadPicker({Key? key}) : super(key: key);
  @override
  LeadPickerState createState() => LeadPickerState();
}

class LeadPickerState extends State<LeadPicker> {
  final FlutterContactPicker _contactPicker = FlutterContactPicker();
  Contact? _contact;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home:  Scaffold(
        appBar: AppBar(
          title: Text('Contact Picker Example App'),
        ),
        body: Center(
          child:  Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
               MaterialButton(
                color: Colors.blue,
                child: Text("CLICK ME"),
                onPressed: () async {
                  Contact? contact = await _contactPicker.selectContact();
                  setState(() {
                    _contact = contact;
                  });
                },
              ),
              Text(
                _contact == null ? 'No contact selected.' : _contact.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}