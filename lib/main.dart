import 'package:connect_x_app/constants/variables/shared.dart';
import 'package:connect_x_app/data/db.dart';
import 'package:connect_x_app/data/g_sheets.dart';
import 'package:connect_x_app/screens/attendance.dart';
import 'package:connect_x_app/screens/layout.dart';
import 'package:connect_x_app/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSheetApi.init();
 // db database = db();
 // database.createdb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(),
        scaffoldBackgroundColor: lightColor,
      ),
      home: LayoutScreen(),
    );
  }
}
