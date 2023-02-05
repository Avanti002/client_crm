
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

Widget myDrawer(BuildContext context){
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
            leading: Icon(Icons.home,color: Colors.black,),
            selectedTileColor: Colors.blue[100],
            title: Text('Home',style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.group,color: Colors.black),
            title: Text('Leads',style: TextStyle(fontWeight: FontWeight.bold)),
            selectedTileColor: Colors.blue[100],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Leadindex()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.contacts,color: Colors.black),
            title: Text('Contacts',style: TextStyle(fontWeight: FontWeight.bold)),
            selectedTileColor: Colors.blue[100],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Contactindex()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.handshake_outlined,color: Colors.black),
            title: Text('Opportunity',style: TextStyle(fontWeight: FontWeight.bold)),
            selectedTileColor: Colors.blue[100],
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Opportunityindex(title: 'Opportunity')));
            },
          ),
          //Divider(),
          ListTile(
            leading: Icon(Icons.how_to_reg,color: Colors.black),
            title: Text('Deals',style: TextStyle(fontWeight: FontWeight.bold)),
            selectedTileColor: Colors.blue[100],
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Dealindex()));
            },
          ),
          ListTile(
            leading: Icon(Icons.call_sharp,color: Colors.black),
            title: Text('Calls',style: TextStyle(fontWeight: FontWeight.bold)),
            selectedTileColor: Colors.blue[100],
            onTap: () => null,
          ),
          // Divider(),
          ListTile(
            title: Text('Meeting',style: TextStyle(fontWeight: FontWeight.bold)),
            selectedTileColor: Colors.blue[100],
            leading: Icon(Icons.meeting_room,color: Colors.black),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateMeet()));
            },
          ),
          ListTile(
            title: Text('Events',style: TextStyle(fontWeight: FontWeight.bold)),
            selectedTileColor: Colors.blue[100],
            
            leading: Icon(Icons.event,color: Colors.black),
            onTap: () {Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CreateEvent()));}
          ),
          ListTile(
            title: Text('Tasks',style: TextStyle(fontWeight: FontWeight.bold)),
            selectedTileColor: Colors.blue[100],
            leading: Icon(Icons.control_point_duplicate,color: Colors.black),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Taskindex()));
            },
          ),
          ListTile(
            title: Text('GeoLocation',style: TextStyle(fontWeight: FontWeight.bold)),
            selectedTileColor: Colors.blue[100],
            leading: Icon(Icons.control_point_duplicate,color: Colors.black),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => LocationPage()));
            },
          ),
          ListTile(
            title: Text('Attendance',style: TextStyle(fontWeight: FontWeight.bold)),
            selectedTileColor: Colors.blue[100],
            leading: Icon(Icons.verified_user,color: Colors.black),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AttendancePage()));
            },
          ),
          ListTile(
            title: Text('Settings',style: TextStyle(fontWeight: FontWeight.bold)),
            selectedTileColor: Colors.blue[100],
            
            leading: Icon(Icons.settings,color: Colors.black),
            onTap: () => null,
          ),
          ],
        ),
      );
}