import 'package:flutter/material.dart';

//choose to begin week on sunday or monday
enum StartWeek {
  monday,
  sunday
}

class CalendarDate extends StatefulWidget{
  CalendarDate({
    Key key,
    this.date,
    this.thisMonth = false,
    this.prevMonth = false,
    this.nextMonth = false,
    this.themeColor,
    this.dateColor,
    this.sundayColor,
    this.startWeek,
    this.startYear,
    this.endYear,
  }) : super(key: key);

  final DateTime date;
  final bool thisMonth;
  final bool prevMonth;
  final bool nextMonth;
  final Color themeColor;
  final Color dateColor;
  final Color sundayColor;
  final StartWeek startWeek;
  final DateTime startYear;
  final DateTime endYear;

  @override
  _CalendarDateState createState() => _CalendarDateState();
}

class _CalendarDateState extends State<CalendarDate> {

  DateTime _currentDateTime;
  DateTime _selectedDateTime;

  List<CalendarDate> _seqDates; //create list for adding dates

  //lists of days names and month names in the app
  final List<String> _weekDaysMon = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  final List<String> _weekDaysSun = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  final List<String> _monthNames = [
    'JANUARY', 'FEBRUARY', 'MARCH',
    'APRIL', 'MAY', 'JUNE',
    'JULY', 'AUGUST', 'SEPTEMBER',
    'OCTOBER', 'NOVEMBER', 'DECEMBER'
  ];

  //number of days for every month
  //begin with 28 days for february
  final List<int> _daysMonth = [
    31, 28, 31, 30,
    31, 30, 31, 31,
    30, 31, 30, 31
  ];

  //----------------------LEAP YEAR------------------------------------------

  //calculate occurrence of leap year
  bool _leapYear(int year) {
    if((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
      return true;
    }
    return false;
  }

  /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
  * add and calculate all the days of a month to a list
  * determine which weekdays the days occurs on
  * get month, value between 1-12
  * list of type CalendarDate */
  List<CalendarDate> getMonth(int month,  int year, { StartWeek startWeek = StartWeek.monday} ) {

    //validate
    if(year == null || month == null || month < 1 || month > 12) throw ArgumentError('Invalid year or month');

    List<CalendarDate> calendarDate = List<CalendarDate>(); // get list of dates

    //show previous and next months' calendar days
    int otherYear; //next or prev year
    int otherMonth; //next or prev month
    int leftDays; //days from prev and next month to add to calendar

    //number of days in a month
    //-1 since _daysMonth starts from 0
    int numOfDays = _daysMonth[month - 1];

    //add one day for february if it is leap year
    if(_leapYear(year) && month == DateTime.february) numOfDays++; //29 days

    //get days for this month
    // add days to this month
    for(int i = 0; i<numOfDays; i++){
      calendarDate.add(
        CalendarDate(
          date: DateTime(year, month, i+1),
          thisMonth: true,
        ),
      );
    }

    /*If the current month does not start on the first day of a week, or/and end
   * at the last day of a week - add dates from prev and next month to fill
   * all rows in the calendar*/

   //fill days from previous month in current month view
   //is filled in the beginning of a week
   //if startWeek starts on a monday and the first day of the month is not on a monday
   //or startweek starts on a sunday and the first day of the month is not on a sunday
    if(startWeek == StartWeek.monday && calendarDate.first.date.weekday != DateTime.monday ||
        startWeek == StartWeek.sunday && calendarDate.first.date.weekday != DateTime.sunday) {

      //if the current month is jan, previous month is december of previous year
      if(month == DateTime.january){
        otherMonth = DateTime.december; //go back to month 12
        otherYear = year - 1; //subtract one year
      } else {
        otherMonth = month - 1; //subtract one month
        otherYear = year; //year is not changed
      }

      //month-1 because _daysMonth starts from index 0 and month starts from 1
      numOfDays = _daysMonth[otherMonth -1];
      if(_leapYear(otherYear) && otherMonth == DateTime.february) numOfDays++;

      //add different amount of days depending on start day
      //example: Jan starts on a friday = 5 and week starts on a monday
      //leftDays = 31 - 5 + 1 = 27 => days 28, 29, 30 and 31 is shown from prev month
      leftDays = numOfDays - calendarDate.first.date.weekday + ((startWeek == StartWeek.sunday) ? 1 : 0);

      for(int i = numOfDays; i>leftDays; i--){
        //add days to start of list from end of prev month
        calendarDate.insert(0, CalendarDate(
          date: DateTime(otherYear, otherMonth, i),
          prevMonth: true,
        ));
      }
    }

    //fill with days from next month in current month view
    //is added for the end of the week
    //if startWeek is on monday and last day of a month does not occur on a sunday
    //if startWeek is on sunday and last day of a month does not occur on a saturday
    if(startWeek == StartWeek.monday && calendarDate.last.date.weekday != DateTime.sunday ||
        startWeek == StartWeek.sunday && calendarDate.last.date.weekday != DateTime.saturday) {

      //month is dec, next month is january next year
      if(month == DateTime.december){
        otherMonth = DateTime.january; //go to month 1
        otherYear = year+1; //add one year
      } else {
        otherMonth = month + 1; //go to next month
        otherYear = year; //year is the same
      }

      //month -1 because _daysMonth starts from index 0 and month starts from 1
      numOfDays = _daysMonth[otherMonth-1];
      if(_leapYear(otherYear) && otherMonth == DateTime.february) numOfDays++;

      //calculate number of days left in a week depending on the week day for the last day
      //example: Month ends on a wednesday = 3 and week starts on a monday
      //leftDays = 7- 3-0 = 4 => day 1, 2, 3 and 4 is shown from next month
      leftDays = 7 - calendarDate.last.date.weekday - ((startWeek == StartWeek.monday) ? 0:1);

      //if(leftDays == -1) leftDays = 6;

      for(int i = 0; i<leftDays; i++){
        //add days to end of list from next month
        calendarDate.add(CalendarDate(
          date: DateTime(otherYear, otherMonth, i+1),
          nextMonth: true,
        ));
      }
    }

    return calendarDate;
  }


  //----------------------------------------------------------------------

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

  //--------GET CURRENT MONTH------------------------------------------------
  void _getCalendar() {
    _seqDates = getMonth(_currentDateTime.month, _currentDateTime.year, startWeek : widget.startWeek);
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

  //-----------------BUILD------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Center(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(5),
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(15),
              ),
              child: _datesView(), //show whole calendar
            ),
          ],
        ),
      ),
    );
  }

  //-----------------------UI-------------------------------------

  //arrow buttons to next and previous months
  Widget _btn(bool next) {
    return InkWell(
      onTap: () { //button is "tapped"
        //if next is true, go to next month, else go to previous month
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

  //Get weekdays from list _weekDaysMon or _weekDaysSun
  Widget _weekDayTitle(int index) {
    return Center(
      //if startWeek is monday, print M first, else print S first
      child: Text((widget.startWeek == StartWeek.monday) ?
        _weekDaysMon[index] : _weekDaysSun[index],
        style: TextStyle(color: widget.themeColor, fontSize: 17, fontWeight: FontWeight.bold),
      ),
    );
  }

  //When dates are clicked on
  Widget _calendarDates(CalendarDate calendarDate) {
    return InkWell(
      onTap: () { //when a date is clicked on

        if(_selectedDateTime != calendarDate.date){
          if(calendarDate.nextMonth && _currentDateTime.isBefore(widget.endYear)){
            //show the view for next month when a date from
            //that month is selected in current view
            _getNextMonth();
          } else if(calendarDate.prevMonth && _currentDateTime.isAfter(widget.startYear)){
            //show the view for prev month when a date from
            //that month is selected in current view
            _getPrevMonth();
          }
          //the clicked on calendar date is selected
          print("Date selected");
          setState(() => _selectedDateTime = calendarDate.date);
        }
      },

      child: Center(
        child: Text(
          //get day
          '${calendarDate.date.day}',
          style: TextStyle(
            color: (calendarDate.thisMonth) //if it is current month and if it is sunday else other day, else other month and sunday else other day
                ? (calendarDate.date.weekday == DateTime.sunday) ? widget.sundayColor : widget.dateColor //different colors for sunday and other weekdays
                : (calendarDate.date.weekday == DateTime.sunday) ? widget.sundayColor.withOpacity(0.5) : widget.dateColor.withOpacity(0.5), //lower opacity for days not in the current month
          ),
        ),
      ),
    );
  }

  //Date selector to show to the user the selected date
  Widget _selector(CalendarDate calendarDate) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: widget.themeColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        decoration: BoxDecoration(
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

  //Create how calendar should be displayed
  //Have a grid with a cross axis count of 7 => 7 columns for 7 days a week
  Widget _displayCalendar() {
    //no dates, return empty container
    if(_seqDates == null) return Container();
    //display calendar as a grid
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      //how many items it needs to build
      itemCount: _seqDates.length + 7, //add one row to calendar length for weekday titles
      //grid with a fixed crossAxisCount (7)
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10,
        crossAxisSpacing: 15,
        crossAxisCount: 7, //show 7 days in a row

      ),
      itemBuilder: (context, index){
        //convert into a widget based on type of item
        if(index < 7) //index is 0-6 - first row
          return _weekDayTitle(index); //first row shows weekday titles
        if(_seqDates[index - 7].date == _selectedDateTime) //date index is the selected date
          return _selector(_seqDates[index - 7]); //that date is marked
        return _calendarDates(_seqDates[index -7]); //return _calendarDates function
      },
    );
  }

  //dates view, put together all functions for the calendar view
  //called in build
  Widget _datesView() {
    return Column(
      children: [
        Row(
          children: [
            //prev button is available until startYear date
            if(_currentDateTime.isAfter(widget.startYear)) _btn(false),
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
            //next month button is available before endYear date
            if(_currentDateTime.isBefore(widget.endYear)) _btn(true)
          ],
        ),
        SizedBox(height: 10),
        //vry nice divider
        Divider(color: Colors.black),
        SizedBox(height: 20),
        Flexible(child: _displayCalendar()),
        SizedBox(height: 15),
        //just for fun
        Text(
          'Date selected is: ${_monthNames[_currentDateTime.month-1]} ${_selectedDateTime.day} ${_currentDateTime.year}',
          style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

}
