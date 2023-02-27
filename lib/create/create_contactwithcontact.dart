import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quantbit_crm/backend/post_contact.dart';
import 'package:quantbit_crm/backend/post_contactwithcontact.dart';
import 'package:quantbit_crm/index/contact_index.dart';
import 'package:quantbit_crm/index/contact_index.dart' as p;

var contact = p.tc;
String name = "";
String num = "";

class ICreateContact extends StatefulWidget {
  const ICreateContact({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ICreateContact> createState() => _ICreateContactState();
}

class _ICreateContactState extends State<ICreateContact> {
  TextEditingController namecontroller = TextEditingController()..text = name;

  TextEditingController mobilenocontroller = TextEditingController()
    ..text = num;
  String? firstname;
  String? lastname;
  String? companyname;
  String? emailid;
  String? mobileno;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contact = p.tc;
    name = contact.replaceAll(RegExp('[^A-Za-z]'), '');
    num = contact.replaceAll(RegExp('[^+0-9]'), '');

    setState(() {
      namecontroller = TextEditingController()..text = name;
      mobilenocontroller = TextEditingController()..text = num;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('contact'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => const Contactindex()),
              );
            },
            child: const Icon(Icons.arrow_back),
          ),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Contactindex()));
                      postIContact(
                          firstname, lastname, companyname, emailid, mobileno);
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
                      controller: namecontroller,
                      decoration: const InputDecoration(
                          labelText: 'First Name', icon: Icon(Icons.person)),
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
                          labelText: 'Last Name', icon: Icon(Icons.person)),
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
                          labelText: 'Company Name',
                          icon: Icon(Icons.account_box)),
                      onChanged: (value) {
                        setState(() {
                          companyname = value;
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
                      controller: mobilenocontroller,
                      decoration: const InputDecoration(
                          labelText: 'Mobile No', icon: Icon(Icons.phone)),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
