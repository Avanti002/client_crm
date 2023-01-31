
import 'package:flutter/material.dart';
import 'package:quantbit_crm/contactindex.dart';
import 'package:quantbit_crm/create_meeting.dart';
import 'package:quantbit_crm/deal.dart';
import 'package:quantbit_crm/home.dart';
import 'package:quantbit_crm/leadindex.dart';
import 'package:quantbit_crm/opportunityindex.dart';
import 'package:quantbit_crm/task.dart';
import 'package:quantbit_crm/login.dart' as login;

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
                MaterialPageRoute(builder: (context) => TasksPage(Goback: (int ) {  },)),
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
                  context, MaterialPageRoute(builder: (context) => Deal()));
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
            title: Text('Tasks',style: TextStyle(fontWeight: FontWeight.bold)),
            selectedTileColor: Colors.blue[100],
            leading: Icon(Icons.control_point_duplicate,color: Colors.black),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => simple()));
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