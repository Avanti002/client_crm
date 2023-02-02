import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quantbit_crm/backend/post_lead.dart';
import 'package:quantbit_crm/index/lead_index.dart';
import 'package:quantbit_crm/test.dart' as tst;
import 'package:http/http.dart' as http;



var leadname=tst.leadind;
var leaddata=tst.temp1;
var temp2;

Future<Data> fetchname() async {
  var headers = {
    'Authorization': 'token da8dde973368af3:f584b09f290bab9',
    'Cookie': 'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
  };
  var request = http.Request('GET', Uri.parse('https://demo.erpdata.in/api/resource/Lead?filters=[["name","=","$leadname"]]&fields=["first_name"]'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    await response.stream.bytesToString().then((value) {
      temp2=value;

      // temp1=value;
      //
      // cName=li.companyName;
      // leadind=temp.toString().substring(18).replaceAll(RegExp('[^A-Za-z0-9-  \t]'), '');
    });
  }
  else {
    print(response.reasonPhrase);
  }
  return Data.fromJson(jsonDecode(request.body));
}
class Data {
  final String name;
  final String data;

  const Data({
    required this.data,
    required this.name,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      data: json['data'],
      name: json['name'],
    );
  }
}

class UpdateLead extends StatefulWidget {
  const UpdateLead({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return UpdateLeadState();
  }
}

class UpdateLeadState extends State<UpdateLead> {
  @override
  void initState() {
    setState(() {
      fetchname();
    });
    print(temp2);
    super.initState();
  }
  TextEditingController fname = TextEditingController()..text=temp2.toString();
  String dropdownvalue = 'Lead';

  String? companyname;
  String? firstname;
  String? lastname;
  String? mobileno;
  String? leadstatus;
  String? emailid;
  String? city;
  String? state;


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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Create Lead'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => const Leadindex()),
              );
            },
            child: const Icon(Icons.arrow_back),
          ),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const Leadindex())));
                      postlead(companyname, firstname, lastname, mobileno,
                          leadstatus, emailid, city, state);
                    },
                    child: const Icon(Icons.check))),
          ]),
      body: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Company Name', icon: Icon(Icons.factory)),
                      onChanged: ((value) {
                        setState(() {
                          companyname = value;
                        });
                      }),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),
                  TextFormField(
                    controller: fname,
                      decoration: const InputDecoration(
                          labelText: 'First Name',

                          icon: Icon(Icons.account_circle)),

                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),
                  TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Last Name',
                          icon: Icon(Icons.account_circle)),
                      onChanged: (value) {
                        setState(() {
                          lastname = value;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),
                  TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Mobile No.', icon: Icon(Icons.phone)),
                      onChanged: (value) {
                        setState(() {
                          mobileno = value;
                        });
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
                        value,
                        ) {
                      setState(() {
                        dropdownvalue = value!;
                        leadstatus = dropdownvalue;
                      });
                    },
                  ),
                  TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Email Id', icon: Icon(Icons.email)),
                      onChanged: (value) {
                        setState(() {
                          emailid = value;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),
                  TextFormField(
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
                  Text(leaddata),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}