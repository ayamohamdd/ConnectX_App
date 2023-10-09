import 'package:connect_x_app/constants/variables/shared.dart';
import 'package:connect_x_app/data/db.dart';
import 'package:connect_x_app/screens/attendant_info.dart';
import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  db attendanceDB =  db();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: darkColor,
        title: Text(
          'Attendance',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: attendantsBuilder(attendants: attendanceDB.attendants),
    );
  }
}
