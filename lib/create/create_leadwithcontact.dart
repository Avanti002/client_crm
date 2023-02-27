import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quantbit_crm/backend/post_lead.dart';
import 'package:quantbit_crm/backend/post_leadwithcontact.dart';
import 'package:quantbit_crm/home.dart' as tmp;
import 'package:quantbit_crm/index/lead_index.dart';
import 'package:quantbit_crm/index/lead_index.dart' as c;


List xyz = [];
var contact=c.ct;
String name="";
String num="";



class ICreateLead extends StatefulWidget {
  const ICreateLead({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ICreateLeadState();
  }
}

class ICreateLeadState extends State<ICreateLead> {
  TextEditingController namecontroller = TextEditingController()
    ..text = name;

  TextEditingController mobilenocontroller = TextEditingController()
    ..text = num;

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
  void initState() {
    // TODO: implement initState
    super.initState();
    contact=c.ct;
    name=contact.replaceAll(RegExp('[^A-Za-z]'), '');
    num=contact.replaceAll(RegExp('[^+0-9]'), '');
    int len = (tmp.lst).length;
    setState(() {
      namecontroller = TextEditingController()..text = name;
      mobilenocontroller = TextEditingController()..text = num;
    });
    for (int i = 0; i < len; i++) {
      var temp;
      temp = tmp.lst[i].toString();
      xyz.add(temp);
    }

  }

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
                      postleadwithcontact(companyname, lastname,
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
                      controller: namecontroller,
                      decoration: const InputDecoration(
                          labelText: 'First Name',
                          icon: Icon(Icons.account_circle)),
                      onChanged: (name) {
                        setState(() {
                          firstname = name;
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
                      controller: mobilenocontroller,
                      decoration: const InputDecoration(
                          labelText: 'Mobile Number',
                          icon: Icon(Icons.account_circle)),


                      onChanged: (num) {
                        setState(() {
                          mobileno = num;
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
                    onChanged: (value,) {
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }   }