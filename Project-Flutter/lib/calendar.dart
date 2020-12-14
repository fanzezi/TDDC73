import 'package:flutter/material.dart';

enum StartWeek { monday } //kan vara överflödig

class CalendarDate extends StatefulWidget{
  CalendarDate({
    Key key,
    this.date,
    this.thisMonth = false,
    this.prevMonth = false,
    this.nextMonth = false
  }) : super(key: key);

  final DateTime date;
  final bool thisMonth;
  final bool prevMonth;
  final bool nextMonth;

  @override
  _CalendarDateState createState() => _CalendarDateState();
}

class _CalendarDateState extends State<CalendarDate> {

  DateTime _currentDateTime;
  DateTime _selectedDateTime;

  List<CalendarDate> _seqDates; //create list for adding dates

  //lists of days names and month names in the app
  final List<String> _weekDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  final List<String> _monthNames = [
    'JANUARY', 'FEBRUARY', 'MARCH',
    'APRIL', 'MAY', 'JUNE',
    'JULY', 'AUGUST', 'SEPTEMBER',
    'OCTOBER', 'NOVEMBER', 'DECEMBER'
  ];
  //number of days for every month
  final List<int> _daysMonth = [
    31, 28, 31, 30,
    31, 30, 31, 31,
    30, 31, 30, 31
  ];

  //if leap year
  bool _leapYear(int year) {
    if(year % 4 == 0){
      if(year % 100 == 0){
        if(year % 400 == 0) return true;

        return false;
      }
      return true;
    }
    return false;
  }

  //calculate all the days of a month in a year with their occurrence in weekdays
  //get month, value between 1-12
  //list of type calendar date
  List<CalendarDate> getMonth(int month, int year, {StartWeek startWeek = StartWeek.monday}) {

    //validate
    if(year == null || month == null || month < 1 || month > 12) throw ArgumentError('Invalid year or month');

    List<CalendarDate> calendarDate = List<CalendarDate>();

    //show previous and next months' calendar days
    int otherYear;
    int otherMonth;
    int leftDays;

    //number of days in a month
    //-1 since _daysMonth starts from 0
    int numOfDays = _daysMonth[month - 1];

    //add one day for february if it is leap year
    if(_leapYear(year) && month == DateTime.february) numOfDays++;

    //get days for this month
    for(int i = 0; i<numOfDays; i++){
      calendarDate.add(
        CalendarDate(
          date: DateTime(year, month, i+1),
          thisMonth: true,
        ),
      );
    }

    //fill days from prev month
    if(startWeek == StartWeek.monday && calendarDate.first.date.weekday != DateTime.monday) {

      //if the current month is jan, previous month is december of previous year
      if(month == DateTime.january){
        otherMonth = DateTime.december;
        otherYear = year - 1;
      } else {
        otherMonth = month - 1;
        otherYear = year;
      }

      //month-1 because _daysMonth starts from index 0 and month starts from 1
      numOfDays = _daysMonth[otherMonth -1];
      if(_leapYear(otherYear) && otherMonth == DateTime.february) numOfDays++;

      leftDays = numOfDays - calendarDate.first.date.weekday + 1;

      for(int i = numOfDays; i>leftDays; i--){
        //add days to start of list to maintain the sequence
        calendarDate.insert(0, CalendarDate(
          date: DateTime(otherYear, otherMonth, i),
          prevMonth: true,
        ));
      }
    }

    //fill with days from next month
    if(startWeek == StartWeek.monday && calendarDate.last.date.weekday != DateTime.sunday) {

      //month is dec, next month is january next year
      if(month == DateTime.december){
        otherMonth = DateTime.january;
        otherYear = year+1;
      } else {
        otherMonth = month + 1;
        otherYear = year;
      }

      //month -1 because _daysMonth starts from index 0 and month starts from 1
      numOfDays = _daysMonth[otherMonth-1];
      if(_leapYear(otherYear) && otherMonth == DateTime.february) numOfDays++;

      leftDays = 7 - calendarDate.last.date.weekday;
      if(leftDays == -1) leftDays = 6;

      for(int i = 0; i<leftDays; i++){
        calendarDate.add(CalendarDate(
          date: DateTime(otherYear, otherMonth, i+1),
          nextMonth: true,
        ));
      }
    }

    return calendarDate;
  }

  @override
  void initState() {
    super.initState();
    //the current month and year
    _currentDateTime = DateTime(DateTime.now().year, DateTime.now().month);
    //select date
    _selectedDateTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() => _getCalendar());
    });
  }

  //get current month
  void _getCalendar() {
    _seqDates = getMonth(_currentDateTime.month, _currentDateTime.year, startWeek: StartWeek.monday);
  }

  //previous month
  void _getPrevMonth() {
    //if it is january = 1, subtract one year and start from month 12 = dec
    if(_currentDateTime.month == 1) {
      _currentDateTime = DateTime(_currentDateTime.year-1, 12);
    } else { //if it is not jan, just go to prev month
      _currentDateTime = DateTime(_currentDateTime.year, _currentDateTime.month-1);
    }
    _getCalendar();
  }

  //next month
  void _getNextMonth() {
    //if it is december = 12, add one year and start from month 1 = jan
    if(_currentDateTime.month == 12) {
      _currentDateTime = DateTime(_currentDateTime.year+1, 1);
    } else { //if it is not dec, just go to next month
      _currentDateTime = DateTime(_currentDateTime.year, _currentDateTime.month+1);
    }
    _getCalendar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Center(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(3),
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(15),
              ),
              child: _datesView(), //show dates
            ),
          ],
        ),
      ),
    );
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
      child: Text(_weekDays[index], style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 14, fontWeight: FontWeight.bold),),
    );
  }

  //calendar element
  Widget _calendarDates(CalendarDate calendarDate) {
    return InkWell(
      onTap: () { //when a date is clicked on

        if(_selectedDateTime != calendarDate.date){
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
          print("Date selected");
          setState(() => _selectedDateTime = calendarDate.date);
          //display events for selected date
          //_dailyEvents(),
          //assert(_events.day == calendarDate.date);
          //print(_events.entries);
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
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(30),
        //border: Border.all(color: Colors.deepPurple, width: 1),
      ),
      child: Container(
        decoration: BoxDecoration(
          //color: Colors.deepPurple.withOpacity(0.7),
          borderRadius: BorderRadius.circular(70),
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
        if(_seqDates[index - 7].date == _selectedDateTime)
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
                  '${_monthNames[_currentDateTime.month-1]} ${_currentDateTime.year}',
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

