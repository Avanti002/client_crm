import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'deal.dart';

// import 'package:syncfusion_flutter_calender/calender.dart';
class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  TextEditingController dateinput = TextEditingController();
  String dropdownvalue = 'None';

  var items = [
    'None',
    'Need Analysis',
    'Value Proposition',
    'Identify Decision Makers',
    'Proposal /Price Quote',
    'Negotiation / Review',
    'Closed Won',
    'Closed Lost',
    'Closed-Lost to Competition',
  ];
  String dropdownvalue1 = 'None';

  var items1 = [
    'None',
    'Existing Business',
    'New Business',

  ];
  String dropdownvalue2 = 'None';

  var items2 = [
    'None',
    'Expectation Mismatch',
    'Price',
    'Unqualified Customer',
    'Lack of Response',
    'Missed Follow Ups',
    'Wrong Target',
    'Competition',
    'Future Interest',
    'Other',


  ];



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
  final _addressLineController = TextEditingController();
  @override
  void initState() {
    dateinput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Create Deal'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => Deal() )
              );
            },
            child: Icon(Icons.arrow_back),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(onTap: () {}, child: Icon(Icons.check))),
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
                        labelText: 'Deal Owner', icon: Icon(Icons.contacts)),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Amount', icon: Icon(Icons.money)),
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'Please enter some text';
                    //   }
                    //   return null;
                    // }
                  ),
                  TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Deal Name', icon: Icon(Icons.circle)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),
                  TextFormField(
                      controller: dateinput,
                      decoration: InputDecoration(
                        labelText: 'Closing Date',
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
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          //you can implement different kind of Date Format here according to your requirement

                          setState(() {
                            dateinput.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {
                          print("Date is not selected");
                        }
                      }),
                  TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Account Name', icon: Icon(Icons.person)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),
                  DropdownButtonFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.arrow_circle_up),
                        labelText: 'Stage',
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
                        });
                      }),
                  DropdownButtonFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.square_foot_rounded),
                        labelText: 'Type',
                      ),
                      value: dropdownvalue1,
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: items1.map((String items1) {
                        return DropdownMenuItem(
                          value: items1,
                          child: Text(items1),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue1 = newValue!;
                        });
                      }),

                  DropdownButtonFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.add_circle_outline_rounded),
                        labelText: 'Reason For Loss',
                      ),
                      value: dropdownvalue2,
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: items2.map((String items2) {
                        return DropdownMenuItem(
                          value: items2,
                          child: Text(items2),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue2 = newValue!;
                        });
                      }),
                  TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Next Step', icon: Icon(Icons.stacked_line_chart)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),
                  TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Probability(%)', icon: Icon(Icons.percent_rounded)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),
                  TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Expected Revenue', icon: Icon(Icons.monetization_on_outlined)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),
                  TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Contact Name', icon: Icon(Icons.contacts_rounded)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),
                  TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Description', icon: Icon(Icons.text_fields)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),
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
                  TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Email Id', icon: Icon(Icons.email)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),
                  TextFormField(
                      controller: _addressLineController,
                      decoration: InputDecoration(
                        labelText: 'Address Line',
                        icon: const Icon(Icons.location_city),
                        suffixIcon: IconButton(
                          onPressed: () => _addressLineController.clear(),
                          icon: const Icon(Icons.clear),
                        ),
                      ),
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
