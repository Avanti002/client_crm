import 'package:flutter/material.dart';
import 'package:quantbit_crm/side.dart';

import 'package:quantbit_crm/deal1.dart';

class Deal extends StatefulWidget {
  const Deal({super.key});
  @override
  State<StatefulWidget> createState() {
    return DealState();
  }
}

class DealState extends State<Deal> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
          appBar: AppBar(
              title: Text("Deals"),
              leading: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NavBar()),
                  );
                },
                child: Icon(
                  Icons.menu, // add custom icons also
                ),
              ),
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.search,
                      size: 26.0,
                    ),
                  ),
                ),
              ]

              //   iconTheme: IconThemeData(
              //
              //     color: Colors.black, // <-- SEE HERE
              //   ),
              //   centerTitle: true,
              //   actions: [IconButton(
              //
              //       onPressed: () {}, icon:  Icon(Icons.menu))],
              // title: const Text('Welcome to Flutter'),
              ),
          body: new Column(
            children: <Widget>[
              // new Number(),
              // new Keyboard(),
            ],
          ),
          floatingActionButton: new FloatingActionButton(
              elevation: 0.0,
              child: new Icon(Icons.add),
              backgroundColor: Colors.blue,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormScreen()),
                );
              })),
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: <Widget>[
      //
      //       ],
      //     ),
      //
      //
      //
      // ),

      //  child: Text('Hello World'),
    );
  }
}
