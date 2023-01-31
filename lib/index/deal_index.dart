import 'package:flutter/material.dart';
import 'package:quantbit_crm/app_drawer.dart';
import 'package:quantbit_crm/create/create_deal.dart';
class Dealindex extends StatefulWidget {
  const Dealindex({super.key});
  @override
  State<StatefulWidget> createState() {
    return DealindexState();
  }
}

class DealindexState extends State<Dealindex> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        drawer: myDrawer(context),
          appBar: AppBar(
              title: Text("Deals"),
              
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
                  MaterialPageRoute(builder: (context) => CreateDeal()),
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
