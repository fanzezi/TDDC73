import 'package:flutter/material.dart';
import 'package:flutter_app/calendar.dart';
import 'package:flutter_app/carousel.dart';
//For the time

import 'calendar.dart';
import 'calendar.dart';
import 'carousel.dart';

void main() {
  runApp(MaterialApp(title: "Project", home: MyApp()));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff79a3b1),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Miniproject"),
      ),
      backgroundColor: Color(0xffd0e8f2),
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: Carousel(
            inputPhotos: [
              'assets/images/image1.jpeg',
              'assets/images/image2.jpeg',
              'assets/images/image3.jpeg',
              //'assets/images/image5.jpg',

        ], inputWidgets: [
          // Widget 1 for Carousel
          CalendarDate(
            themeColor: Colors.grey,//_themeColor,
            dateColor: Colors.black, //_dateColor,
            sundayColor: Colors.grey,// _sundayColor,
            //choose to start week on monday or sunday
            startWeek: StartWeek.monday,
            //choose time range for calendar
            startYear: DateTime(2020, 1),
            endYear: DateTime(2021, 12),
          ),

          //Widget 2 for Carousel
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Image(image: AssetImage('assets/images/dog.jpeg')),
                Container(padding: EdgeInsets.all(20), child: Text("yo")),
              ],
            ),
          ),

          //Widget 3 for Carousel
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Image(image: AssetImage('assets/images/grapes.jpg')),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
