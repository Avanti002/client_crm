import 'package:flutter/material.dart';
import 'package:quantbit_crm/opportunityindex.dart';
import 'package:quantbit_crm/pick_contact1.dart';
import 'package:quantbit_crm/deal.dart';
import 'package:quantbit_crm/home.dart';
import 'package:quantbit_crm/login.dart' as login;
import 'package:quantbit_crm/leadindex.dart';
import 'package:quantbit_crm/meeting1.dart';
import 'package:quantbit_crm/task.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(login.usernm),
            accountEmail: Text(login.emailid),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://static.thenounproject.com/png/1041818-200.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              // image: DecorationImage(
              //     fit: BoxFit.fill,
              //     image: NetworkImage(
              //         'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TasksPage(Goback: (int ) {  },)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.group),
            title: Text('Leads'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => index()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.contacts),
            title: Text('Contacts'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => contactindex(title: "Contact ")),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.handshake_outlined),
            title: Text('Opportunity'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Opportunityindex(title: 'Opportunity')));
            },
          ),
          //Divider(),
          ListTile(
            leading: Icon(Icons.how_to_reg),
            title: Text('Deals'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Deal()));
            },
          ),
          ListTile(
            leading: Icon(Icons.call_sharp),
            title: Text('Calls'),
            onTap: () => null,
          ),
          // Divider(),
          ListTile(
            title: Text('Meeting'),
            leading: Icon(Icons.meeting_room),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddNewTask()));
            },
          ),
          ListTile(
            title: Text('Tasks'),
            leading: Icon(Icons.control_point_duplicate),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => simple()));
            },
          ),
          ListTile(
            title: Text('Settings'),
            leading: Icon(Icons.settings),
            onTap: () => null,
          ),
        ],
      ),
    );
  }
}
