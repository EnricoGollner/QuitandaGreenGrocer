import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UtilsServices {
  static void showFlutterToast({required String message, bool isError = false}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: isError ? Colors.red : Colors.white,
        textColor: isError ? Colors.white : Colors.black,
        fontSize: 14);
  }

  static Uint8List generateQRCode(String data) {
    final String base64String = data.split(',').last;
    return base64.decode(base64String);
  }
}
