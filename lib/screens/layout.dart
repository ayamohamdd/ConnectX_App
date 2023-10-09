import 'package:flutter/material.dart';
import 'package:connect_x_app/constants/variables/shared.dart';
import 'package:connect_x_app/screens/attendance.dart';
import 'package:connect_x_app/screens/home.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  List<Widget> screens = [];
  int currentIndex = 0;

  @override
  void initState() {
    screens = const [HomeScreen(), AttendanceScreen()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const SizedBox(
        height: 75,
        width: 75,
      ),
      bottomNavigationBar: BottomAppBar(
        color: darkColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          backgroundColor: darkColor,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.white,
          onTap: (index) {
            if (index == 1) {
              setState(() {
                hitAttendance = true;
              });
            } else {
              hitAttendance = false;
            }
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Attendance',
            ),
          ],
        ),
      ),
      body: IndexedStack(
        children: screens,
        index: currentIndex,
      ),
    );
  }
}
