import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  DateTime _selectedDate = DateTime.now();
  bool _isKeySelected = false;
  bool _isAttendanceSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Calendar Widget
            TableCalendar(
              focusedDay: _selectedDate,
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDate = selectedDay;
                });
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Checkboxes
            Row(
              children: [
                Checkbox(
                  value: _isKeySelected,
                  onChanged: (value) {
                    setState(() {
                      _isKeySelected = value!;
                    });
                  },
                ),
                Text('Key'),
                SizedBox(width: 20),
                Checkbox(
                  value: _isAttendanceSelected,
                  onChanged: (value) {
                    setState(() {
                      _isAttendanceSelected = value!;
                    });
                  },
                ),
                Text('Attendance'),
              ],
            ),
            Spacer(),
            // Confirm Button
            ElevatedButton(
              onPressed: () {
                // Handle the button press
                print('Selected Date: $_selectedDate');
                print('Key Selected: $_isKeySelected');
                print('Attendance Selected: $_isAttendanceSelected');
              },
              child: Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}