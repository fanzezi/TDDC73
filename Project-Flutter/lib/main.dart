import 'package:flutter/material.dart';
import 'package:flutter_app/calendar.dart';

void main() {
  runApp(MaterialApp(
      title: "Project",
      home: MyApp()
  ));
}

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

//show dates, maybe add for month and year view later?
enum CalendarView{dates}

class _MyAppState extends State<MyApp> {

  DateTime _curDateTime;
  DateTime _selDateTime;

  List<CalendarDate> _seqDates; //create list for adding dates
  CalendarView _currentView = CalendarView.dates; //shows dates as default (only option right now)
  //lists of days names and month names in the app
  final List<String> _weekDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  final List<String> _monthNames = [
    'JANUARY', 'FEBRUARY', 'MARCH',
    'APRIL', 'MAY', 'JUNE',
    'JULY', 'AUGUST', 'SEPTEMBER',
    'OCTOBER', 'NOVEMBER', 'DECEMBER'
  ];

  @override
  void initState() {
    super.initState();
    //the current month and year
    _curDateTime = DateTime(DateTime.now().year, DateTime.now().month);
    //select date
    _selDateTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() => _getCalendar());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Center(
          child: Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(15),
            ),
            child: _datesView(), //show dates
          )
      ),
    );
  }

  //get current month
  void _getCalendar() {
    _seqDates = Calendar().getMonth(_curDateTime.month, _curDateTime.year, startWeek: StartWeek.monday);
  }

  //previous month
  void _getPrevMonth() {
    //if it is january = 1, subtract one year and start from month 12 = dec
    if(_curDateTime.month == 1) {
      _curDateTime = DateTime(_curDateTime.year-1, 12);
    } else { //if it is not jan, just go to prev month
      _curDateTime = DateTime(_curDateTime.year, _curDateTime.month-1);
    }
    _getCalendar();
  }

  //next month
  void _getNextMonth() {
    //if it is december = 12, add one year and start from month 1 = jan
    if(_curDateTime.month == 12) {
      _curDateTime = DateTime(_curDateTime.year+1, 1);
    } else { //if it is not dec, just go to next month
      _curDateTime = DateTime(_curDateTime.year, _curDateTime.month+1);
    }
    _getCalendar();
  }

  //arrow buttons to next and previous months
  Widget _btn(bool next) {
    return InkWell(
      onTap: () { //button is "tapped"
        //go to next or previous month
        setState(() => (next) ? _getNextMonth() : _getPrevMonth());

      },
      child: Container(
        alignment: Alignment.center,
        width: 50,
        height: 50,
        //arrow forward shows next month, arrow back shows previous month
        child: Icon((next) ? Icons.arrow_forward_ios : Icons.arrow_back_ios, color: Colors.black),
      ),
    );
  }

  //get weekdays
  Widget _weekDayTitle(int index) {
    return Center(
      child: Text(_weekDays[index], style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 17, fontWeight: FontWeight.bold),),
    );
  }

  //calendar element
  Widget _calendarDates(CalendarDate calendarDate) {
    return InkWell(
      onTap: () { //when a date is clicked on
        if(_selDateTime != calendarDate.date){
          if(calendarDate.nextMonth){
            //show the view for next month when a date from
            //that month is selected in current view
            _getNextMonth();
          } else if(calendarDate.prevMonth){
            //show the view for prev month when a date from
            //that month is selected in current view
            _getPrevMonth();
          }
          //the selected calendar date is shown as selected
          setState(() => _selDateTime = calendarDate.date);
        }
      },
      child: Center(
        child: Text(
          //get day
          '${calendarDate.date.day}',
          style: TextStyle(
            color: (calendarDate.thisMonth) //current month
                ? (calendarDate.date.weekday == DateTime.sunday) ? Colors.deepPurpleAccent : Colors.black //purple when it is sunday, black for the rest
                : (calendarDate.date.weekday == DateTime.sunday) ? Colors.deepPurpleAccent.withOpacity(0.5) : Colors.black.withOpacity(0.5), //lower opacity for days not in the current month
          ),
        ),
      ),
    );
  }

  //date selector
  Widget _selector(CalendarDate calendarDate) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.black, width: 4),
        gradient: LinearGradient(
          colors: [Colors.white70.withOpacity(0.1), Colors.black],
          stops: [0.1, 1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.9),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            '${calendarDate.date.day}',
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w700
            ),
          ),
        ),
      ),
    );
  }

  //display calendar
  Widget _displayCalendar() {
    //no dates, return empty container
    if(_seqDates == null) return Container();
    //display calendar as a grid
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: _seqDates.length + 7,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 20,
        crossAxisSpacing: 25,
        crossAxisCount: 7, //show 7 days in a row

      ),
      itemBuilder: (context, index){
        if(index < 7) return _weekDayTitle(index);
        if(_seqDates[index - 7].date == _selDateTime)
          return _selector(_seqDates[index - 7]);
        return _calendarDates(_seqDates[index -7]);
      },
    );
  }

  //dates view
  Widget _datesView() {
    return Column(
      children: [
        Row(
          children: [
            _btn(false),
            //month and year
            Expanded(
              child: Center(
                child: Text(
                  //display current month and year
                  '${_monthNames[_curDateTime.month-1]} ${_curDateTime.year}',
                  style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            //next month button
            _btn(true)
          ],
        ),
        SizedBox(height: 10),
        //vry nice divider
        Divider(color: Colors.black),
        SizedBox(height: 20),
        Flexible(child: _displayCalendar()),
      ],
    );
  }
}