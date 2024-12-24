import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_app/task_history.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
    _handleDateSelection(day); // day is selcted date in calender
  }

// passing selected date to task history page after converting into string as per database
  void _handleDateSelection(DateTime selectedDay) {
    String date = DateFormat('yyyy-MM-dd').format(selectedDay);
    print(date);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TaskHistory(
                date:
                    date))); //date is string type required parameter in task history page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Task History Calendar",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.purple,
      ),
      body: content(),
    );
  }

  Widget content() {
    return Column(
      children: [
        Text(""),
        Container(
          child: TableCalendar(
            locale: "en_US",
            rowHeight: 43,
            headerStyle:
                HeaderStyle(formatButtonVisible: false, titleCentered: true),
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) => isSameDay(day, today),
            focusedDay: today,
            firstDay: DateTime.utc(2024, 12, 01),
            lastDay: DateTime.utc(2030, 3, 15),
            onDaySelected: _onDaySelected,
          ),
        ),
      ],
    );
  }
}
