import 'package:flutter/material.dart';

class CalendarDate{
  CalendarDate({
    this.date,
    this.thisMonth = false,
    this.prevMonth = false,
    this.nextMonth = false
  });

  final DateTime date;
  final bool thisMonth;
  final bool prevMonth;
  final bool nextMonth;

}

enum StartWeek { monday } //kan vara överflödig

class Calendar {

  //number of days for every month
  final List<int> _daysMonth = [31, 28, 31, 30,
                                31, 30, 31, 31,
                                30, 31, 30, 31];

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
}

