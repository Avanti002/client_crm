
import 'package:flutter/material.dart';
import 'package:quantbit_crm/app_drawer.dart';
import 'package:quantbit_crm/task1.dart';
import 'package:quantbit_crm/deal1.dart';


class simple extends StatefulWidget {
  const simple({super.key});
  @override
  State<StatefulWidget>createState() {
    return simpleState();
  }
}
class simpleState extends State<simple>{


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
          drawer: myDrawer(context),
          appBar: AppBar(
              title: Text("Tasks"),
              
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
              child: new Icon(Icons.add
              ),
              backgroundColor: Colors.blue,
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Fon()),);
              }
          )
      ),
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