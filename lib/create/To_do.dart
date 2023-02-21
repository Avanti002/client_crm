import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quantbit_crm/backend/Post_todo.dart';
import 'package:quantbit_crm/backend/post_lead.dart';
import 'package:quantbit_crm/create/create_lead.dart';
import 'package:quantbit_crm/home.dart' as tmp;
import 'package:quantbit_crm/index/lead_index.dart';


List xyz=[];
class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TodoState();
  }
}

class TodoState extends State<Todo> {

  String dropdownvalue = 'Low';

  String? allocated_to;
  String? completed_by;
  String? priority ;
  String? comment;



  var items = [
    'Low',
    'Medium',
    'High',

  ];

  final _formKey = GlobalKey<FormState>();
  TextEditingController dateInput = TextEditingController();
  @override
  void initState() {
    dateInput.text = "";
    // TODO: implement initState
    super.initState();
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
                              builder: ((context) => const CreateLead())));

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
                          labelText: 'Assign To', icon: Icon(Icons.factory)),
                      onChanged: ((value) {
                        setState(() {
                          allocated_to = value;
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
                          labelText: 'Comment',
                          icon: Icon(Icons.account_circle)),
                      onChanged: (value) {
                        setState(() {
                          comment= value;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),
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

                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person_outline_outlined),
                      labelText:'Priority',
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
                        priority = dropdownvalue;
                      });
                    },
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
