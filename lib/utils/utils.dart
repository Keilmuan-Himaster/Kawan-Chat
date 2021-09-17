import 'package:intl/intl.dart';

class Utils {
  // return `just time` if timestamp == today
  // return `date & time` if timestamp != today
  static String timestampToDatetime(String? timestamp) {
    if (timestamp == null) {
      timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    }

    DateTime dateChat =
        DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));

    DateTime dateNow = DateTime.now();

    var format;

    if (dateNow.day == dateChat.day &&
        dateNow.month == dateChat.month &&
        dateNow.year == dateChat.year) {
      // today
      format = DateFormat("Hm");
    } else {
      // yesterday
      format = DateFormat("dd MMM kk:mm");
    }

    return "${format.format(dateChat)}";
  }
}
