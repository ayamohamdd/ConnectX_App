import 'dart:async';

import 'package:connect_x_app/constants/variables/shared.dart';
import 'package:connect_x_app/data/database.dart';
import 'package:connect_x_app/data/db.dart';
import 'package:connect_x_app/screens/attendant_info.dart';
import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});
  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  db attendanceDB = db();
  AttendanceDatabase attendanceDatabase = AttendanceDatabase();
  List<Map>? attendants = [];

  myReadData() async {
    List<Map> response = await attendanceDatabase.readData('attendants');

    setState(() {
      attendants!.clear();
      attendants!.addAll(response);
    });
  }

  @override
  void initState() {
    super.initState();
    myReadData();

    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      myReadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: darkColor,
        title: const Text(
          'Attendance',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 7),
        child: attendantsBuilder(attendants: attendants!),
      ),
    );
  }
}
