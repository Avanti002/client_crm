import 'package:flutter/material.dart';
import 'package:quantbit_crm/backend/post_lead.dart';
import 'package:quantbit_crm/home.dart' as tmp;
import 'package:quantbit_crm/index/lead_index.dart';
import 'package:quantbit_crm/contact_services.dart';


List xyz=[];
class CreateLead extends StatefulWidget {
  const CreateLead({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CreateLeadState();
  }
}

class CreateLeadState extends State<CreateLead> {

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
    int len=(tmp.lst).length;
    for(int i=0;i<len;i++)
      {
        var temp;
        temp=tmp.lst[i].toString();
        xyz.add(temp);
      }
    print(xyz);

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
                      decoration: const InputDecoration(
                          labelText: 'First Name',
                          icon: Icon(Icons.account_circle)),
                      onChanged: (value) {
                        setState(() {
                          firstname = value;
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
                      ElevatedButton.icon(                          
  onPressed: () {
     Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ContactServices(),)
      );                                      
  },
  label: Text('ContactServices',style:TextStyle(fontSize: 20)), 
  icon: Icon( // <-- Icon
    Icons.login_rounded,
    size: 30.0,
  ),
),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}