import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:quantbit_crm/accounts.dart';
import 'package:quantbit_crm/contact.dart';
import 'package:quantbit_crm/side.dart';

class Accountindex extends StatefulWidget {
  const Accountindex({super.key, required this.title});
  final String title;

  @override
  State<Accountindex> createState() => _Accountindex();
}

class _Accountindex extends State<Accountindex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(widget.title),
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) => NavBar()),
                );
              },
              child: Icon(
                Icons.menu,
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
              onTap: () {},
            ),
            SpeedDialChild(
              child: const Icon(Icons.person_add, color: Colors.white),
              label: 'Add Account',
              backgroundColor: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Accounts(
                            title: '',
                          )),
                );
              },
            ),
          ],
        ));
  }
}
