import 'package:connect_x_app/constants/components/snackbar_widget.dart';
import 'package:connect_x_app/data/db.dart';
import 'package:connect_x_app/data/g_sheets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

String? recognizedName;
db attendanceDB =  db();
void uploadImage(String image, BuildContext context) async {
  Dio dio = Dio(BaseOptions(
    headers: {'Content-Type': 'multipart/form-data'},
  ));
  try {
    var data = {
      'image': await MultipartFile.fromFile(image, filename: basename(image)),
    };
    FormData formData = FormData.fromMap(data);
    Response response = await dio.post(
        'https://754a-102-44-90-4.ngrok-free.app/recognize',
        data: formData);
    if (response.statusCode == 200) {
      print(response.data);
      List<dynamic> recognizedNames = response.data['recognized_names'];
      if (recognizedNames.isNotEmpty) {
        if (recognizedNames[0] != 'Unknown') {
          recognizedName = recognizedNames[0];
          attendanceDB.insertdb(image: image, date: '', name: recognizedName!);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBarWidget.create(
              'Hello ${recognizedName![0].toUpperCase() + recognizedName!.substring(1)}!',
              true,
              20,
            ),
          );
          await UserSheetApi.insert([
            (recognizedName![0].toUpperCase() + recognizedName!.substring(1)),
            true,
            DateFormat.yMMMd().format(DateTime.now())
          ]);
        } else if (recognizedNames[0] == 'Unknown') {
          recognizedName =
              'Access denied. You\'re not in our system as a team member';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBarWidget.create('$recognizedName', false, 14),
          );
        }
      } else {
        recognizedName = 'No face recognized';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBarWidget.create('$recognizedName', false, 20),
        );
      }

      print('Recognized Names: $recognizedNames');
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (error) {
    print('Error: $error');
  }
}
