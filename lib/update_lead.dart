import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quantbit_crm/app_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:auto_reload/auto_reload.dart';
import 'dart:convert';
import 'package:quantbit_crm/index/lead_index.dart' as lead;
import 'package:quantbit_crm/accessToken.dart' as at;
import 'package:quantbit_crm/service_locator.dart';
import 'package:quantbit_crm/home.dart';
import 'package:url_launcher/url_launcher.dart';




String accessToken=at.tokenAccess;
String first_name="";
String company_name="";
String email_id="";
String last_name="";
String state="";
String status="";
String city="";
String mobile_no="";
String lead_owner="";
String lead_status="";

String dropdownvalue = 'Lead';

  var items = [
    'Lead',
    'Open',
    'Replied',
    'Opportunity',
    'Quation',
    'Lost Quotation',
    'interested',
    'Converted',
    'Do Not Contact',
  ];


Future<List<Data>> fetchLeadind() async {
List<Data> list=[];
var httpsUri = Uri(scheme: 'https',host: 'demo.erpdata.in',path: '/api/resource/Lead/${lead.leadind}');
var res = await http
.get(httpsUri,headers: {
  'Authorization': '$accessToken',
  'Cookie': 'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
});
if (res.statusCode == 200) {
  //name==json.decode(res.body)["data"]["name"];
  first_name=(json.decode(res.body)["data"]["first_name"]).toString();
  last_name=(json.decode(res.body)["data"]["last_name"]).toString();
  company_name=(json.decode(res.body)["data"]["company_name"]).toString();
  email_id=(json.decode(res.body)["data"]["email_id"]).toString();
  state=(json.decode(res.body)["data"]["state"]).toString();
  status=(json.decode(res.body)["data"]["status"]).toString();
  city=(json.decode(res.body)["data"]["city"]).toString();
  mobile_no=(json.decode(res.body)["data"]["mobile_no"]).toString();
  lead_owner=(json.decode(res.body)["data"]["lead_owner"]).toString();
  dropdownvalue=(json.decode(res.body)["data"]["status"]).toString();
  fetchLeadind();
}
return list;
}
Future<List<Data>> updateLead() async {
List<Data> list=[];
var headers = {
  'Authorization': '$accessToken',
  'Cookie': 'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
};
var request = http.Request('PUT', Uri.parse('https://demo.erpdata.in/api/resource/Lead/${lead.leadind}?status=$lead_status'));

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
  print(await response.stream.bytesToString());
  
}
else {
  print(response.reasonPhrase);
}
return list;
}


class Data {
  final String company_name;
  final String data;

  const Data({
    required this.data,
    required this.company_name,

  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      data: json['data'],
      company_name: json['company_name'],
    );
  }
}
class UpdateLead extends StatefulWidget {
  const UpdateLead({super.key});
  @override
  State<StatefulWidget> createState() {
    return UpdateLeadState();
  }
}
abstract class _UpdateLead extends State<UpdateLead>
    implements AutoReloader {}
class UpdateLeadState extends _UpdateLead with AutoReloadMixin{
  final Duration autoReloadDuration = const Duration(seconds: 1);
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();
  TextEditingController companyNamecontroller = TextEditingController()..text="";
  TextEditingController firstnamecontroller=TextEditingController()..text="";
  TextEditingController emailidcontroller=TextEditingController()..text="";
TextEditingController lastnamecontroller=TextEditingController()..text="";
TextEditingController statecontroller=TextEditingController()..text="";
TextEditingController statuscontroller=TextEditingController()..text="";
TextEditingController citycontroller=TextEditingController()..text="";
TextEditingController mobilenocontroller=TextEditingController()..text="";
TextEditingController leadownercontroller=TextEditingController()..text="";
  @override
void initState() {
  setState(() {
    lead.fetchCname();
    fetchLeadind();
    });
  super.initState();
  startAutoReload();
}
@override
void autoReload() {
  setState(() {
    companyNamecontroller = TextEditingController()..text=company_name;
  firstnamecontroller=TextEditingController()..text=first_name;
  emailidcontroller=TextEditingController()..text=email_id;
lastnamecontroller=TextEditingController()..text=last_name;
statecontroller=TextEditingController()..text=state;
statuscontroller=TextEditingController()..text=status;
citycontroller=TextEditingController()..text=city;
mobilenocontroller=TextEditingController()..text=mobile_no;
leadownercontroller=TextEditingController()..text=lead_owner;
dropdownvalue;
  });
}
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Update Lead',
      home: Scaffold(
        drawer: myDrawer(context),
        appBar: AppBar(
            title: Text("Update Lead"),

            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    updateLead();
                    
                      ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Lead Status Updated !')));
                    
                   
                  },
                  child: const Icon(
                    Icons.check,
                    size: 26.0,
                  ),
                ),
              ),
            ]),
        body:
        Padding(padding: EdgeInsets.all(20),
              child: 
          Column(
            children:<Widget>[
              
              //SizedBox(height:25),
              TextFormField(
                readOnly:true,
                controller: companyNamecontroller,
                      decoration: const InputDecoration(
                          labelText: 'Company Name', icon: Icon(Icons.factory)),
                      onChanged: ((value) {

                      }),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),
                  TextFormField(
                    readOnly:true,
                    controller: firstnamecontroller,
                      decoration: const InputDecoration(
                          labelText: 'First Name',
                          icon: Icon(Icons.account_circle)),
                      onChanged: (value) {

                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),
                  TextFormField(
                    readOnly:true,
                    controller: lastnamecontroller,
                      decoration: const InputDecoration(
                          labelText: 'Last Name',
                          icon: Icon(Icons.account_circle)),
                      onChanged: (value) {

                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),
                  TextFormField(
                    readOnly:true,
                    controller: mobilenocontroller,
                      decoration: const InputDecoration(
                          labelText: 'Mobile No.', icon: Icon(Icons.phone)),
                      onChanged: (value) {

                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person_outline_outlined),
                      labelText: 'Lead Status',
                    ),
                    value: dropdownvalue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (
                        value
                        ) {
                          setState(() {
                            lead_status=value.toString();
                          });
                          
                          
                             
                    },
                  ),
                  TextFormField(
                    readOnly:true,
                    controller: emailidcontroller,
                      decoration: const InputDecoration(
                          labelText: 'Email Id', icon: Icon(Icons.email)),
                      onChanged: (value) {

                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),
                  TextFormField(
                    readOnly:true,
                    controller:citycontroller,
                      decoration: const InputDecoration(
                          labelText: 'city', icon: Icon(Icons.location_city)),
                      onChanged: (value) {
                        setState(() {
                          city = value;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),
                  TextFormField(
                    readOnly:true,
                    controller: statecontroller,
                    // onSaved: (val) => _cardDetails.cardHolderName = val,
                      decoration: const InputDecoration(
                          labelText: 'State',
                          icon: Icon(Icons.south_america_rounded)),
                      onChanged: (value) {
                        setState(() {
                          state = value;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),
                  TextFormField(
                    readOnly:true,
                    controller: leadownercontroller,
                    // onSaved: (val) => _cardDetails.cardHolderName = val,
                      decoration: const InputDecoration(
                          labelText: 'Lead Owner',
                          icon: Icon(Icons.account_circle)),
                      // onChanged: (value) {
                      //   setState(() {
                      //     leadowner = value;
                      //   });
                      // },
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Please enter some text';
                      //   }
                      //   return null;
                      //
                      ),
              SizedBox(
                height: 40,
              ),
              
            ]

          ),
          ),
        floatingActionButton: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(onPressed: (){whatsapp(mobile_no);},child:Image.network('https://cdn-icons-png.flaticon.com/512/4494/4494494.png')),
                    SizedBox(width: 30,),
                    FloatingActionButton(onPressed: (){_service.call(mobile_no);},child:Image.network('https://cdn-icons-png.flaticon.com/512/724/724664.png')),
                    SizedBox(width: 30,),
                    FloatingActionButton(onPressed: (){_service.sendSms(mobile_no);},child:Image.network('https://cdn-icons-png.flaticon.com/512/234/234129.png')),
                    SizedBox(width: 30,),
                    FloatingActionButton(onPressed: (){ _service.sendEmail(email_id);},child:Image.network('https://cdn-icons-png.flaticon.com/512/2913/2913990.png')),
                  ],),
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