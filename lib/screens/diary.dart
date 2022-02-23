import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:grafter/shared/custom_app_bar.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: TableCalendar(
        focusedDay: selectedDay,
        firstDay: DateTime(1990),
        lastDay: DateTime(2050),
        calendarFormat: format,
        onFormatChanged: (CalendarFormat _format) {
          setState(() {
            format = _format;
          });
        },
        startingDayOfWeek: StartingDayOfWeek.monday,
        daysOfWeekVisible: true,

        //Day Changed
        onDaySelected: (DateTime selectDay, DateTime focusDay) {
          setState(() {
            selectedDay = selectDay;
            focusedDay = focusDay;
          });
        },
        selectedDayPredicate: (DateTime date) {
          return isSameDay(selectedDay, date);
        },

        //To Style the Calendar
        calendarStyle: CalendarStyle(
            isTodayHighlighted: true,
            selectedDecoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
            selectedTextStyle: TextStyle(color: Colors.white),
            todayDecoration: BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            )),
      ),
    );
  }
}
