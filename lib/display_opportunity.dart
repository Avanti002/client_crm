import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:quantbit_crm/app_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:auto_reload/auto_reload.dart';
import 'dart:convert';
import 'package:quantbit_crm/index/opportunity_index.dart' as oppo;
import 'package:quantbit_crm/accessToken.dart' as at;
import 'package:quantbit_crm/index/opportunity_index.dart';
import 'package:quantbit_crm/service_locator.dart';
import 'package:quantbit_crm/home.dart';
String temp=oppo.tech;
String accessToken=at.tokenAccess;
String opportunity_from="";
String party="";
String title="";
String opportunity_type="";
String sales_stage="";
String status="";
 String expected_closing="";
 String probability="";
Future<List<Data>> fetchOppoind() async {
  List<Data> list=[];
  var httpsUri = Uri(scheme: 'https',host: 'demo.erpdata.in',path: '/api/resource/Opportunity/${oppo.oppoind}');
  var res = await http
      .get(httpsUri,headers: {
    'Authorization': '$accessToken',
    'Cookie': 'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
  });
  if (res.statusCode == 200) {
    //name==json.decode(res.body)["data"]["name"];
    opportunity_from=(json.decode(res.body)["data"]["opportunity_from"]);
    title=(json.decode(res.body)["data"]["title"]).toString();
    party=(json.decode(res.body)["data"]["party_name"]).toString();
    print(opportunity_from);
     //print(temp);
    fetchOppoind();
  }
  return list;
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
Future<List<Data>> updateOppo() async {
  List<Data> list=[];
  var headers = {
    'Authorization': '$accessToken',
    'Cookie': 'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
  };
  var request = http.Request('PUT', Uri.parse('https://demo.erpdata.in/api/resource/Opportunity/${oppo.oppoind}?status=$status'));

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



class DisplayOppo extends StatefulWidget {
  const DisplayOppo({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<DisplayOppo> createState() => _DisplayOppo();
}

class _DisplayOppo extends State<DisplayOppo> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController opportunity_fromcontroller = TextEditingController()..text="";
  TextEditingController partycontroller=TextEditingController()..text="";
  TextEditingController titlecontroller=TextEditingController()..text="";
  TextEditingController opportunity_typecontroller=TextEditingController()..text="";
  TextEditingController sales_stagecontroller=TextEditingController()..text="";
  TextEditingController statuscontroller=TextEditingController()..text="";
  TextEditingController expected_closingcontroller=TextEditingController()..text="";
  TextEditingController probabilitycontroller=TextEditingController()..text="";

  TextEditingController dateinput = TextEditingController()..text="";

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
    setState(() {oppo.fetchOpponame();
    opportunity_fromcontroller = TextEditingController()..text=opportunity_from;
    partycontroller=TextEditingController()..text=party;
    titlecontroller=TextEditingController()..text=title;
    opportunity_typecontroller=TextEditingController()..text=opportunity_type;
    sales_stagecontroller=TextEditingController()..text=sales_stage;
    statuscontroller=TextEditingController()..text=status;
    dateinput=TextEditingController()..text=expected_closing;
    probabilitycontroller=TextEditingController()..text=probability;

      fetchOppoind();
    });
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(
                context,
                MaterialPageRoute(
                    builder: (context) => Opportunityindex(title: '',)),
              );
            },
            child: const Icon(Icons.arrow_back),
          ),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                    onTap: () {
                      updateOppo();

                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Opportunity Updated !')));
                    }, child: const Icon(Icons.check))),
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
                  controller: titlecontroller,
                      decoration: const InputDecoration(
                          labelText: 'Opportunity name', icon: Icon(Icons.person)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),
                  TextFormField(
                      controller:opportunity_typecontroller,
                      decoration: const InputDecoration(
                          labelText: 'Opportunity type', icon: Icon(Icons.person)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),
                  TextFormField(
                      controller: opportunity_fromcontroller,
                      decoration: const InputDecoration(
                          labelText: 'Opportunity from', icon: Icon(Icons.person)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),

                  TextFormField(
                      controller: partycontroller,
                      decoration: const InputDecoration(
                          labelText: 'Party', icon: Icon(Icons.person)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),
                  TextFormField(
                    controller: sales_stagecontroller,
                      decoration: const InputDecoration(
                          labelText: 'Sales Stage',
                          icon: Icon(Icons.account_box)),
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
                        status=value.toString();

                        //leadstatus = dropdownvalue;
                      });
                    },
                  ),
                  TextField(

                    controller: dateInput,
                    //editing controller of this TextField
                    decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today), //icon of text field
                        labelText: "Enter Date" //label text of field
                    ),
                    readOnly: true,
                    //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2100));

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        setState(() {
                          dateInput.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {}
                    },
                  ),
                  TextFormField(
                    controller: probabilitycontroller,
                      onChanged: (
    value,
    ) {
    setState(() {
    probability=value.toString();

    //leadstatus = dropdownvalue;
    });},
                      decoration: const InputDecoration(
                          labelText: 'Probability',
                          icon: Icon(Icons.account_box)),
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