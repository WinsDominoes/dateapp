import 'package:flutter/material.dart';

void main() {
  runApp( MaterialApp(
       home: Home()
  ));
}

class Home extends  StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    DateTime dt1 = DateTime.parse("2021-12-23 11:47:00");
    DateTime dt2 = DateTime.parse("2018-09-12 10:57:00");

    Duration diff = dt1.difference(dt2);

    return Scaffold(
         appBar: AppBar(
            title: Text("Date App"),
            backgroundColor: Colors.redAccent,
         ),
          body: Container(
             alignment: Alignment.center,
             padding: EdgeInsets.all(20),
             child: Column(
               children:[
         
                      Text("DT1:" + dt1.toString()),
                      Text("DT2:" + dt2.toString()),

                      Text("Difference in Days: " + diff.inDays.toString()),
                      Text("Difference in Hours: " + diff.inHours.toString()),
                      Text("Difference in Minutes: " + diff.inMinutes.toString()),
                      Text("Difference in Seconds: " + diff.inSeconds.toString()),

                ]
             ),
          )
      );
  }
}