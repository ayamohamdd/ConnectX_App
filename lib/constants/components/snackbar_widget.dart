import 'package:connect_x_app/constants/variables/shared.dart';
import 'package:flutter/material.dart';

class SnackBarWidget {
  static SnackBar create(String message, bool success, double fontSize) {
    return SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
                fontFamily: regularFont,
              ),
            ),
          ),
          const Spacer(),
          Icon(
            success ? Icons.check : Icons.close,
            color: success ? Colors.green : Colors.red,
            size: 30,
          )
        ],
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: const Color(0xff292929),
    );
  }
}
