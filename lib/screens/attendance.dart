import 'package:connect_x_app/constants/components/snackbar_widget.dart';
import 'package:connect_x_app/screens/attendant_info.dart';
import 'package:flutter/material.dart';
import 'package:connect_x_app/constants/variables/shared.dart';
import 'package:connect_x_app/data/database.dart';
import 'package:connect_x_app/data/db.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  db attendanceDB = db();
  AttendanceDatabase attendanceDatabase = AttendanceDatabase();
  List<Map>? attendants = [];

  Future<void> myReadData() async {
    List<Map> response = await attendanceDatabase.readData('attendants');
    setState(() {
      attendants!.addAll(response);
    });
  }

  @override
  void initState() {
    myReadData();
    super.initState();
  }

  void isAttendance() {
    if (hitAttendance == true) {
      setState(() {
        attendants!.clear();
        myReadData();
      });
    }
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
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {
            attendants!.clear();
          });
          return myReadData();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 7),
          child: attendantsBuilder(attendants: attendants!),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Transform.translate(
        offset: Offset(0, 40),
        child: SizedBox(
          height: 75,
          width: 75,
          child: FloatingActionButton(
            foregroundColor: Colors.transparent,
            backgroundColor: darkColor,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBarWidget.create('Hello Attendants', true, 20),
              );
            },
            tooltip: '',
            child: const Icon(
              Icons.emoji_emotions,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}
