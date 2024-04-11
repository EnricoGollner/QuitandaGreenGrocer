import 'dart:convert';
import 'dart:typed_data';

class QRCodeUtil {
  static Uint8List generateQRCode(String data) {
    final String base64String = data.split(',').last;
    return base64.decode(base64String);
  }
}