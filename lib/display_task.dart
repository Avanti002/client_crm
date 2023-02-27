import 'package:auto_reload/auto_reload.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quantbit_crm/index/task_index.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quantbit_crm/index/task_index.dart' as task;
import 'package:quantbit_crm/index/task_index.dart';
import 'package:quantbit_crm/accessToken.dart' as at;

String accessToken = at.tokenAccess;
String subject = "";
String project = "";
String status = "";
String priority = "";
String issue = "";
String task_weight = "";
String type = "";
String parent_task = "";
String exp_start_date = "";
String progress = "";
String description = "";
Future<List<Data>> fetchTaskind() async {
  List<Data> list = [];
  var httpsUri = Uri(
      scheme: 'https',
      host: 'mobilecrm.erpdata.in',
      path: '/api/resource/Task/${task.taskind}');
  var res = await http.get(httpsUri, headers: {
    'Authorization': '$accessToken',
    'Cookie':
        'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
  });
  if (res.statusCode == 200) {
    subject = (json.decode(res.body)["data"]["subject"]).toString();
    project = (json.decode(res.body)["data"]["project"]).toString();
    status = (json.decode(res.body)["data"]["status"]).toString();
    priority = (json.decode(res.body)["data"]["priority"]).toString();
    issue = (json.decode(res.body)["data"]["issue"]).toString();

    type = (json.decode(res.body)["data"]["type"]).toString();
    parent_task = (json.decode(res.body)["data"]["parent_task"]).toString();
    exp_start_date =
        (json.decode(res.body)["data"]["exp_start_date"]).toString();
    progress = (json.decode(res.body)["data"]["progress"]).toString();
    description = (json.decode(res.body)["data"]["description"]).toString();
    task_weight = (json.decode(res.body)["data"]["task_weight"]).toString();

    fetchTaskind();
  }
  return list;
}

Future<List<Data>> updateTask() async {
  List<Data> list = [];
  var headers = {
    'Authorization': '$accessToken',
    'Cookie':
        'full_name=Guest; sid=Guest; system_user=no; user_id=Guest; user_image='
  };
  var request = http.Request(
      'PUT',
      Uri.parse(
          'https://$curl/api/resource/Task/${task.taskind}?status=$status'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
    print('update');
  } else {
    print(response.reasonPhrase);
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

class DisplayTask extends StatefulWidget {
  const DisplayTask({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DisplayTaskState();
  }
}

abstract class _DisplayTask extends State<DisplayTask>
    implements AutoReloader {}

class DisplayTaskState extends _DisplayTask with AutoReloadMixin {
  @override
  final Duration autoReloadDuration = const Duration(seconds: 2);
  TextEditingController subjectcontroller = TextEditingController()
    ..text = subject;
  TextEditingController projectcontroller = TextEditingController()
    ..text = project;
  TextEditingController statuscontroller = TextEditingController()..text = "";
  TextEditingController prioritycontroller = TextEditingController()
    ..text = priority;

  TextEditingController issuecontroller = TextEditingController()..text = issue;
  TextEditingController typecontroller = TextEditingController()..text = type;

  TextEditingController parent_taskcontroller = TextEditingController()
    ..text = parent_task;

  TextEditingController exp_start_datecontroller = TextEditingController()
    ..text = exp_start_date;

  TextEditingController progresscontroller = TextEditingController()
    ..text = progress;

  TextEditingController descriptioncontroller = TextEditingController()
    ..text = description;
  TextEditingController task_weightcontroller = TextEditingController()
    ..text = task_weight;

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

  String dropdownvalue3 = 'Low';

  var items3 = [
    'Low',
    'Medium',
    'High',
    'Urgent',
  ];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    setState(() {
      task.fetchTaskname();
      fetchTaskind();
      statuscontroller = TextEditingController()..text = status;
    });
    dateinput.text = "";
    super.initState();
    startAutoReload();
  }

  @override
  void autoReload() {
    setState(() {
      subjectcontroller = TextEditingController()..text = subject;
      projectcontroller = TextEditingController()..text = project;
      prioritycontroller = TextEditingController()..text = priority;
      issuecontroller = TextEditingController()..text = issue;
      statuscontroller = TextEditingController()..text = status;
      typecontroller = TextEditingController()..text = type;
      parent_taskcontroller = TextEditingController()..text = parent_task;
      exp_start_datecontroller = TextEditingController()..text = exp_start_date;
      progresscontroller = TextEditingController()..text = progress;
      descriptioncontroller = TextEditingController()..text = description;
      task_weightcontroller = TextEditingController()..text = task_weight;
      dateinput = TextEditingController();
      dropdownvalue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(subject),
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
                      updateTask();

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Task Status Updated !')));
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
                    controller: subjectcontroller,
                    decoration: const InputDecoration(
                        labelText: 'Subject', icon: Icon(Icons.add)),
                    onChanged: ((value) {
                      setState(() {
                        subject = value;
                      });
                    }),
                  ),
                  TextFormField(
                    controller: projectcontroller,
                    decoration: const InputDecoration(
                        labelText: 'Project', icon: Icon(Icons.add_business)),
                    // onChanged: ((value) {
                    //   setState(() {
                    //     project = value;
                    //   });
                    // }),
                  ),
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
                        status = value.toString();
                        //leadstatus = dropdownvalue;
                      });
                    },
                  ),
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
                    controller: issuecontroller,
                    decoration: const InputDecoration(
                        labelText: 'Issue', icon: Icon(Icons.add_rounded)),
                    // onChanged: ((value) {
                    //   setState(() {
                    //     issue = value;
                    //   });
                    // }),
                  ),
                  TextFormField(
                    controller: task_weightcontroller,
                    decoration: const InputDecoration(
                        labelText: 'Weight', icon: Icon(Icons.circle)),
                    // onChanged: ((value) {
                    //   setState(() {
                    //     task_weight = value;
                    //   });
                    // }),
                  ),
                  TextFormField(
                    controller: typecontroller,
                    decoration: const InputDecoration(
                        labelText: 'Type', icon: Icon(Icons.library_add)),
                    // onChanged: ((value) {
                    //   setState(() {
                    //     type = value;
                    //   });
                    // }),
                  ),
                  TextFormField(
                    controller: parent_taskcontroller,
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
                      controller: exp_start_datecontroller,
                      //controller: dateinput,
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
                            // exp_start_date=dateinput.text as DateTime?;//set output date to TextField value.
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
                    controller: progresscontroller,
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
                    controller: descriptioncontroller,
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
