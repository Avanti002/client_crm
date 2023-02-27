import 'dart:convert';
import 'package:auto_reload/auto_reload.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quantbit_crm/backend/post_opportunity.dart';
import 'package:quantbit_crm/index/contact_index.dart';
import 'package:quantbit_crm/index/opportunity_index.dart';
import 'package:quantbit_crm/test.dart' as imp;
import 'package:http/http.dart' as http;
import 'package:quantbit_crm/accessToken.dart' as at;

String accessToken = at.tokenAccess;
String? Lead;
String? temp;
String? temp1;
String? opportunity_type;
String? sales_stage;
String? status1;
String? probability;
var dsp;
String dsp1 = "";
String company_name = "";
Future<List<Data>> fetchLeadind1() async {
  List<Data> list = [];
  var httpsUri = Uri(
      scheme: 'https',
      host: 'mobilecrm.erpdata.in',
      path: '/api/resource/Lead/${temp1}');
  var res = await http.get(httpsUri, headers: {
    'Authorization': '$accessToken',
    'Cookie':
        'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
  });
  if (res.statusCode == 200) {
    //name==json.decode(res.body)["data"]["name"];

    company_name = (json.decode(res.body)["data"]["company_name"]).toString();
    print(company_name);

    fetchLeadind1();
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

class Opportunity extends StatefulWidget {
  const Opportunity({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Opportunity> createState() {
    return OpportunityState();
  }
}

abstract class _Opportunity extends State<Opportunity>
    implements AutoReloader {}

class OpportunityState extends _Opportunity with AutoReloadMixin {
  @override
  final Duration autoReloadDuration = Duration(seconds: 2);
  final _formKey = GlobalKey<FormState>();
  TextEditingController companyNamecontroller = TextEditingController()
    ..text = "";
  //TextEditingController dateinput = TextEditingController();
  String dropdownvalue = 'Open';
  var items = [
    'Open',
    'Quotaion',
    'Converted',
    'Lost',
    'Replied',
    'Closed ',
  ];
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();

    setState(() {
      companyNamecontroller = TextEditingController()..text = company_name;

      fetchLeadind1();
    });
    startAutoReload();
  }

  @override
  void autoReload() {
    setState(() {
      fetchLeadind1();
      companyNamecontroller = TextEditingController()..text = company_name;
      dropdownvalue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Create Opportunity"),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(
                context,
                MaterialPageRoute(
                    builder: (context) => Opportunityindex(
                          title: '',
                        )),
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
                              builder: (context) =>
                                  const Opportunityindex(title: "")));
                      postoppo(
                          opportunity_type, sales_stage, status1, probability);
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
                  FutureBuilder(
                    future: imp.fetchCNameList(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return DropdownButtonFormField(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person_outline_outlined),
                            labelText: 'Select Lead',
                          ),
                          value: Lead,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: imp.lst1.map((items) {
                            return DropdownMenuItem(
                              value: items.toString(),
                              child: Text(items['name']),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              imp.fetchCNameList();
                              temp = value.toString();
                              temp1 = temp
                                  .toString()
                                  .substring(7)
                                  .replaceAll(RegExp('[^A-Za-z0-9-  \t]'), '');
                              print(temp1);
                              //dsp1=dsp();

                              //dsp1=dsp.toString().substring(7).replaceAll(RegExp('[^A-Za-z0-9-  \t]'), '');
                            });
                          },
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),

                  TextFormField(
                      controller: companyNamecontroller,
                      decoration: const InputDecoration(
                          labelText: 'Opportunity name',
                          icon: Icon(Icons.person)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),
                  TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Opportunity type',
                          icon: Icon(Icons.person)),
                      onChanged: ((value) {
                        setState(() {
                          opportunity_type = value;
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
                          labelText: 'Opportunity from',
                          icon: Icon(Icons.person)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),

                  // TextFormField(
                  //     decoration: const InputDecoration(
                  //         labelText: 'Party', icon: Icon(Icons.person)),
                  //     validator: (value) {
                  //       if (value!.isEmpty) {
                  //         return 'Please enter some text';
                  //       }
                  //       return null;
                  //     }),
                  TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Sales Stage',
                          icon: Icon(Icons.account_box)),
                      onChanged: ((value) {
                        setState(() {
                          sales_stage = value;
                        });
                      }),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person_outline_outlined),
                      labelText: 'Status',
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
                        status1 = dropdownvalue;
                      });
                    },
                  ),

                  TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Probability',
                          icon: Icon(Icons.account_box)),
                      onChanged: ((value) {
                        setState(() {
                          probability = value;
                        });
                      }),
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
