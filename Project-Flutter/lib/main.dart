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
      appBar: AppBar(
        backgroundColor: Color(0xff79a3b1),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Miniproject"),
      ),
      backgroundColor: Color(0xffd0e8f2),
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child:
          Carousel(
              photos: [
                'assets/images/image1.jpeg',
                'assets/images/image2.jpeg',
                'assets/images/image3.jpeg',
              ],

              inputWidgets: [
            // Widget 1
            CalendarDate(
		themeColor: _themeColor,
              	dateColor: _dateColor,
              	sundayColor: _sundayColor,
              	//choose to start week on monday or sunday
              	startWeek: StartWeek.monday,
		//choose time range for calendar 
              	startYear: DateTime(2020, 1),
              	endYear: DateTime(2021, 12),	
	    ),
            //Widget 2
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  color: Colors.white70,
                  child: Text("Hello there"),),
            //Widget 3
            Container(

              padding: EdgeInsets.all(20),
              child: Image(image: AssetImage('assets/images/dog.jpeg')))
          ]),
      ),
    );
  }
}
