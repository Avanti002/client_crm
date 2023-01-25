import 'package:flutter/material.dart';
import 'package:quantbit_crm/accountsindex.dart';

class Accounts extends StatefulWidget {
  const Accounts({Key? key, required String title}) : super(key: key);

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  String dropdownvalue = 'None';

  var items = [
    'None',
    'Invalid Number',
    'Call Back',
    'Ringing',
    'Converted For Demo',
    'Call not received',
    'Yet to be called',
    'Details Shared On WhatsApp',
  ];

  final _formkey = GlobalKey<FormState>();
  final _addressLineController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Create Account'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => Accountindex(
                            title: '',
                          ))));
            },
            child: Icon(Icons.arrow_back),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(onTap: () {}, child: Icon(Icons.check))),
          ]),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Account Name', icon: Icon(Icons.factory)),
                    ),
                    TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Phone', icon: Icon(Icons.phone)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        }),
                    TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Account Site',
                            icon: Icon(Icons.web_rounded)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        }),
                    DropdownButtonFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.factory_sharp),
                          labelText: 'Industry',
                        ),
                        value: dropdownvalue,
                        icon: Icon(Icons.arrow_drop_down_circle_sharp),
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
                        decoration: const InputDecoration(
                            labelText: 'Annual Revenue',
                            icon: Icon(Icons.monetization_on_outlined)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some Number';
                          }
                          return null;
                        }),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
