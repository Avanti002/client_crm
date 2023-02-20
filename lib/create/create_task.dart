import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:quantbit_crm/backend/post_task.dart';
import 'package:quantbit_crm/index/task_index.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CreateTaskState();
  }
}

class CreateTaskState extends State<CreateTask> {
  String? subject;
  // String? project;
  // String? issue;
  // String? type;
  String? status;
  String? priority;
  // String? task_weight;
  // String? parent_task;
  DateTime? exp_start_date;
  // String? exp_end_date;
  // String? progress;
  //Float? expected_time;
  // String? description;
  TextEditingController dateinput = TextEditingController();
  String dropdownvalue = 'Open';

  var items = [
    'Open',
    'Working',
    'Pending Review',
    'Overdue',
    'Template',
    'Completed',
    'Cancelled',
  ];

  // String dropdownvalue2 = 'Not Started';
  //
  // var items2 = [
  //   'Not Started',
  //   'Deferred',
  //   'In Progress',
  //   'Completed',
  //   'Waiting for input',
  // ];
  String dropdownvalue3 = 'Low';

  var items3 = [
    'Low',
    'Medium',
    'High',
    'Urgent',
  ];

  // String dropdownvalue4 = 'None';
  //
  // var items4 = [
  //   'None',
  //   'Daily',
  //   'Weekly',
  //   'Monthly',
  //   'Yearly',
  // ];

  // String dropdownvalue = 'None';
  //
  // var items = [
  //   'Non
  //   'Need Analysis',
  //   'Value Proposition',
  //   'Identify Decision Makers',
  //   'Proposal/Price Quote',
  //   'Negotiation/Review',
  //   'Closed Won',
  //   'Closed Lost',
  //   'Closed-Lost to Competition',
  // ];
  // var items1 =[
  //   'Existing Business',
  //   'New Business',
  //
  // ];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    dateinput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Add Task'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => Taskindex()));
            },
            child: Icon(Icons.arrow_back),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Taskindex()));
                      sendData(subject, status, priority, exp_start_date);
                    },
                    child: Icon(Icons.check))),
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
                        labelText: 'Subject', icon: Icon(Icons.add)),
                    onChanged: ((value) {
                      setState(() {
                        subject = value;
                      });
                    }),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Project', icon: Icon(Icons.add_business)),
                    // onChanged: ((value) {
                    //   setState(() {
                    //     project = value;
                    //   });
                    // }),
                  ),
                  DropdownButtonFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.offline_pin_rounded),
                        labelText: 'Status',
                      ),
                      value: dropdownvalue,
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                          status = dropdownvalue;
                        });
                      }),
                  DropdownButtonFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.add_circle_outline_rounded),
                        labelText: 'Priority',
                      ),
                      value: dropdownvalue3,
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: items3.map((String items3) {
                        return DropdownMenuItem(
                          value: items3,
                          child: Text(items3),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue3 = newValue!;
                          priority = dropdownvalue3;
                        });
                      }),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Issue', icon: Icon(Icons.add_rounded)),
                    // onChanged: ((value) {
                    //   setState(() {
                    //     issue = value;
                    //   });
                    // }),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Weight', icon: Icon(Icons.circle)),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    // onChanged: ((value) {
                    //   setState(() {
                    //     task_weight = value;
                    //   });
                    // }),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Type', icon: Icon(Icons.library_add)),
                    // onChanged: ((value) {
                    //   setState(() {
                    //     type = value;
                    //   });
                    // }),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Parent Task',
                        icon: Icon(Icons.adjust_rounded)),
                    // onChanged: ((value) {
                    //   setState(() {
                    //     parent_task = value;
                    //   });
                    // }),
                  ),
                  TextFormField(
                      controller: dateinput,
                      decoration: InputDecoration(
                        labelText: 'Expected Start Date',
                        icon: const Icon(Icons.calendar_today_rounded),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(
                                2000), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('dd-mm-yyyy').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          //you can implement different kind of Date Format here according to your requirement

                          setState(() {
                            // dateinput.text =
                            //     formattedDate;
                            dateinput.text = formattedDate;
                            exp_start_date = dateinput.text
                                as DateTime?; //set output date to TextField value.
                          });
                        } else {
                          print("Date is not selected");
                        }
                      }),
                  // TextFormField(
                  //     controller: dateinput,
                  //     decoration: InputDecoration(
                  //       labelText: 'Expected End Date',
                  //       icon: const Icon(Icons.calendar_today_rounded),
                  //     ),
                  //     readOnly: true,
                  //     onTap: () async {
                  //       DateTime? pickedDate = await showDatePicker(
                  //           context: context,
                  //           initialDate: DateTime.now(),
                  //           firstDate: DateTime(
                  //               2000), //DateTime.now() - not to allow to choose before today.
                  //           lastDate: DateTime(2101));
                  //
                  //       if (pickedDate != null) {
                  //         print(
                  //             pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  //         String formattedDate =
                  //         DateFormat('yyyy-MM-dd').format(pickedDate);
                  //         print(
                  //             formattedDate); //formatted date output using intl package =>  2021-03-16
                  //         //you can implement different kind of Date Format here according to your requirement
                  //
                  //         setState(() {
                  //           dateinput.text =
                  //               formattedDate; //set output date to TextField value.
                  //           exp_end_date=dateinput.text;
                  //         });
                  //       } else {
                  //         print("Date is not selected");
                  //       }
                  //     }),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Progress',
                        icon: Icon(Icons.percent_rounded)),
                    // onChanged: ((value) {
                    //   setState(() {
                    //     progress = value;
                    //   });
                    // }),
                  ),
                  // TextFormField(
                  //   decoration: const InputDecoration(
                  //       labelText: 'Expected Time(in hours)', icon: Icon(Icons.punch_clock_rounded)),
                  //   onChanged: ((value) {
                  //     setState(() {
                  //       expected_time = value;
                  //     });
                  //   }),
                  // ),

                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Description',
                        icon: Icon(Icons.text_fields)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    //        onChanged: ((value) {
                    //   setState(() {
                    //  description = value;
                    //   });
                    // }),),
                  ),
                  // DropdownButtonFormField(
                  //     decoration: const InputDecoration(
                  //       icon: Icon(Icons.crop_square),
                  //       labelText: 'stage',
                  //     ),
                  //     value: dropdownvalue,
                  //     icon: Icon(Icons.keyboard_arrow_down),
                  //     items: items.map((String items) {
                  //       return DropdownMenuItem(
                  //         value: items,
                  //         child: Text(items),
                  //       );
                  //     }).toList(),
                  //     onChanged: (String? newValue) {
                  //       setState(() {
                  //         dropdownvalue = newValue!;
                  //       });
                  //     }),
                  // DropdownButtonFormField(
                  //     decoration: InputDecoration(
                  //       icon: Icon(Icons.type_specimen),
                  //       labelText: 'Type',
                  //     ),
                  //     value: dropdownvalue,
                  //     icon: Icon(Icons.keyboard_arrow_down),
                  //     items: items.map((String items) {
                  //       return DropdownMenuItem(
                  //         value: items1,
                  //         child: Text(items1),
                  //       );
                  //     }).toList(),
                  //     onChanged: (String? newValue) {
                  //       setState(() {
                  //         dropdownvalue = newValue!;
                  //       });
                  //     }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
