import 'package:flutter/material.dart';
import 'package:flutter_app/calendar.dart';
import 'package:flutter_app/carousel.dart';

import 'calendar.dart';
import 'calendar.dart';
import 'carousel.dart';

void main() {
  runApp(MaterialApp(
    title: "Project",
    home: MyApp())
  );

}

class MyApp extends StatelessWidget {
  //This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.cyan.withOpacity(0.5),
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child:
          Carousel(inputWidgets: [CalendarDate(),Text("Hello there"),
            Container(
              color: Colors.red,
            width: 50,height: 50,)
          ]),
      ),
    );
  }
}

