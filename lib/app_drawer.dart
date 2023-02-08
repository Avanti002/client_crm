import 'package:flutter/material.dart';
import 'package:quantbit_crm/create/create_event.dart';
import 'package:quantbit_crm/face_detection/attendance.dart';
import 'package:quantbit_crm/index/contact_index.dart';
import 'package:quantbit_crm/create/create_meeting.dart';
import 'package:quantbit_crm/index/deal_index.dart';
import 'package:quantbit_crm/home.dart';
import 'package:quantbit_crm/index/lead_index.dart';
import 'package:quantbit_crm/index/opportunity_index.dart';
import 'package:quantbit_crm/index/task_index.dart';
import 'package:quantbit_crm/login.dart' as login;
import 'package:quantbit_crm/location_page.dart';
import 'package:quantbit_crm/test.dart';

Widget myDrawer(BuildContext context) {
  return Drawer(
    width: 320,
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          accountName: Text(login.usernm),
          accountEmail: Text(login.emailid),
          currentAccountPicture: CircleAvatar(
            child: ClipOval(
              child: Image.network(
                'https://cdn-icons-png.flaticon.com/512/1782/1782916.png',
                fit: BoxFit.cover,
                width: 90,
                height: 90,
              ),
            ),
          ),
          decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
          ),
        ),

        ListTile(
          leading: const Icon(
            Icons.home,
            color: Colors.black,
          ),
          selectedTileColor: Colors.blue[100],
          title:
              const Text('Home', style: TextStyle(fontWeight: FontWeight.bold)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.group, color: Colors.black),
          title: const Text('Leads',
              style: TextStyle(fontWeight: FontWeight.bold)),
          selectedTileColor: Colors.blue[100],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Leadindex()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.contacts, color: Colors.black),
          title: const Text('Contacts',
              style: TextStyle(fontWeight: FontWeight.bold)),
          selectedTileColor: Colors.blue[100],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Contactindex()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.handshake, color: Colors.black),
          title: const Text('Opportunity',
              style: TextStyle(fontWeight: FontWeight.bold)),
          selectedTileColor: Colors.blue[100],
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const Opportunityindex(title: 'Opportunity')));
          },
        ),
        //Divider(),
        // ListTile(
        //   leading: Icon(Icons.how_to_reg,color: Colors.black),
        //   title: Text('Deals',style: TextStyle(fontWeight: FontWeight.bold)),
        //   selectedTileColor: Colors.blue[100],
        //   onTap: () {
        //     Navigator.push(
        //         context, MaterialPageRoute(builder: (context) => Dealindex()));
        //   },
        // ),
        ListTile(
          leading: const Icon(Icons.call_sharp, color: Colors.black),
          title: const Text('Calls',
              style: TextStyle(fontWeight: FontWeight.bold)),
          selectedTileColor: Colors.blue[100],
          onTap: () => null,
        ),
        // Divider(),
        ListTile(
          title: const Text('Meeting',
              style: TextStyle(fontWeight: FontWeight.bold)),
          selectedTileColor: Colors.blue[100],
          leading: const Icon(Icons.meeting_room, color: Colors.black),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CreateMeet()));
          },
        ),
        // ListTile(
        //   title: Text('Events',style: TextStyle(fontWeight: FontWeight.bold)),
        //   selectedTileColor: Colors.blue[100],

        //   leading: Icon(Icons.event,color: Colors.black),
        //   onTap: () {Navigator.push(
        //         context, MaterialPageRoute(builder: (context) => CreateEvent()));}
        // ),
        ListTile(
          leading:
              const Icon(Icons.send_time_extension_sharp, color: Colors.black),
          title:
              const Text('Test', style: TextStyle(fontWeight: FontWeight.bold)),
          selectedTileColor: Colors.blue[100],
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Test()));
          },
        ),
        ListTile(
          title: const Text('Tasks',
              style: TextStyle(fontWeight: FontWeight.bold)),
          selectedTileColor: Colors.blue[100],
          leading:
              const Icon(Icons.control_point_duplicate, color: Colors.black),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Taskindex()));
          },
        ),
        ListTile(
          title: const Text('GeoLocation',
              style: TextStyle(fontWeight: FontWeight.bold)),
          selectedTileColor: Colors.blue[100],
          leading: const Icon(Icons.location_on, color: Colors.black),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LocationPage()));
          },
        ),
        ListTile(
          title: const Text('Attendance',
              style: TextStyle(fontWeight: FontWeight.bold)),
          selectedTileColor: Colors.blue[100],
          leading: const Icon(Icons.verified_user, color: Colors.black),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AttendancePage()));
          },
        ),
        ListTile(
          title: const Text('Settings',
              style: TextStyle(fontWeight: FontWeight.bold)),
          selectedTileColor: Colors.blue[100],
          leading: const Icon(Icons.settings, color: Colors.black),
          onTap: () => null,
        ),
      ],
    ),
  );
}
