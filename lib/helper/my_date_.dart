import 'package:flutter/material.dart';

class MyDate {
  static String getFormattedTime(
      {required BuildContext context, required String time}) {
    final data = DateTime.fromMillisecondsSinceEpoch((int.parse(time)));
    return TimeOfDay.fromDateTime(data).format(context);
  }
}
