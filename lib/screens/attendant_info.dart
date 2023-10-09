import 'dart:io';
import 'package:connect_x_app/constants/variables/shared.dart';
import 'package:connect_x_app/data/database.dart';
import 'package:flutter/material.dart';

AttendanceDatabase attendanceDatabase = AttendanceDatabase();
Widget attendantItem(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  child: Container(
    height: 100,
    width: double.infinity,
    decoration:
BoxDecoration(
        color: darkColor, borderRadius: BorderRadius.circular(50)),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          CircleAvatar(
              radius: 40.0,
              backgroundImage: FileImage(File(model["image"]))),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model['name'][0].toUpperCase() + model["name"].substring(1)}',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: lightColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5,),
                Text(
                  '${model["date"]}',
                  style:  TextStyle(
                    color: lightColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          IconButton(
            onPressed: () {
              attendanceDatabase.deleteData(
                  'attendants', 'id = ${model["id"]}');
            },
            icon: Icon(
              Icons.delete,
              color: lightColor,
            ),
          ),
        ],
      ),
    ),
  ),
  onDismissed: (direction) {
    attendanceDatabase.deleteData('attendants', 'id = ${model["id"]}');
  },
);
Widget attendantsBuilder({
  required List<Map> attendants,
}) =>
    ListView.separated(
      itemBuilder: (context, index) {
        return attendantItem(attendants[index], context);
      },
      separatorBuilder: (context, index) => SizedBox(height: 10,),
      itemCount: attendants.length,
    );
Widget myseperator() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 30.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );
