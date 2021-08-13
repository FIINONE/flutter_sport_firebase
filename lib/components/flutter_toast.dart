import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> buildToast(String message) {
  return Fluttertoast.showToast(msg: message);
}
