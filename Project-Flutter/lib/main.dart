import 'package:flutter/material.dart';
import 'package:flutter_app/calendar.dart';
import 'package:flutter_app/carousel.dart';

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
      backgroundColor: Colors.pink,
      body: carousel(),
    );
  }
}


/*return MaterialApp(
      title: 'Project',

      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        backgroundColor: Colors.white,
      ),
      home: //CalendarDate(),
      carousel(),
    ); */