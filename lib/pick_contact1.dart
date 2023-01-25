import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:quantbit_crm/contact.dart';
import 'package:quantbit_crm/side.dart';
//import 'package:quantbit_crm/pick_contact.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';


class contactindex extends StatefulWidget {
  const contactindex({super.key, required this.title});
  final String title;

  @override
  State<contactindex> createState() => _contactindex();
}

class _contactindex extends State<contactindex> {
  final FlutterContactPicker _contactPicker = new FlutterContactPicker();
  Contact? _contact;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(widget.title),
            leading: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NavBar()),
                );
              },
              child: Icon(
                Icons.menu, // add custom icons also
              ),
            ),


            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.search,
                    size: 26.0,
                  ),
                ),
              ),
            ]),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.add_event,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.arrow_circle_down_rounded,
                  color: Colors.white),
              label: 'Import from Address Book',
              backgroundColor: Colors.blue,
              onTap: () async {
                Contact? contact = await _contactPicker.selectContact();
                setState(() {
                  _contact = contact;});

                }

            ),
            SpeedDialChild(
              child: const Icon(Icons.person_add, color: Colors.white),
              label: 'create contact',
              backgroundColor: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Contacts(
                        title: 'create Contact',
                      )),
                );
              },
            ),
          ],
        ));

  }
}