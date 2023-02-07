import 'package:flutter/material.dart';
import 'package:quantbit_crm/backend/post_contact.dart';
import 'package:quantbit_crm/index/contact_index.dart';

class CreateContact extends StatefulWidget {
  const CreateContact({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CreateContact> createState() => _CreateContactState();
}

class _CreateContactState extends State<CreateContact> {
  String? firstname;
  String? lastname;
  String? companyname;
  String? emailid;
  String? mobileno;
  final _formKey = GlobalKey<FormState>();

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
                      postContact(
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
                      decoration: const InputDecoration(
                          labelText: 'First Name', icon: Icon(Icons.person)),
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
                      decoration: const InputDecoration(
                          labelText: 'Mobile No.',
                          icon: Icon(Icons.phone_android_sharp)),
                      onChanged: (value) {
                        setState(() {
                          mobileno = mobileno;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some number';
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
