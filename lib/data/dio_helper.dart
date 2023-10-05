import 'package:connect_x_app/constants/components/snackbar_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

  String? recognizedName;
  void uploadImage(String image,BuildContext context) async {
    Dio dio = Dio(BaseOptions(
      headers: {'Content-Type': 'multipart/form-data'},
    ));
    try {
      var data = {
        'image': await MultipartFile.fromFile(image, filename: basename(image)),
      };
      FormData formData = FormData.fromMap(data);
      Response response = await dio.post(
          'https://28f0-102-44-90-4.ngrok-free.app/recognize',
          data: formData);
      if (response.statusCode == 200) {
        List<dynamic> recognizedNames = response.data['recognized_names'];
        if (recognizedNames.isNotEmpty && recognizedNames[0] != 'Unknown') {
          recognizedName = recognizedNames[0];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBarWidget.create(
                'Hello ${recognizedName![0].toUpperCase() + recognizedName!.substring(1)}!',
                true),
          );
        } else {
          recognizedName = 'No face recognized';
        }
        
        print('Recognized Names: $recognizedNames');
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    print(pickedFile!.path);
    if (pickedFile != null) {
      uploadImage(pickedFile.path,context);
    } else {
      return;
    }
  }

