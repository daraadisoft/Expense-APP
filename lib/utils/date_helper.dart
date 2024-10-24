import 'package:easy_localization/easy_localization.dart';

class DateHelper {
  static int convertDateToMilliSecond({required String date}) {
    try {
      DateFormat dateFormat = DateFormat('dd-MMM-yyyy');
      return dateFormat.parse(date).millisecondsSinceEpoch;
    } catch (e) {
      return 0;
    }
  }

  static String getMonthName({required int month}) {
    const List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    if (month < 1 || month > 12) {
      throw ArgumentError('Month must be between 1 and 12');
    }

    return months[month - 1];
  }

  static String getDayName({required String date}) {
    try {
      DateFormat inputFormat = DateFormat("dd-MMM-yyyy");
      DateTime dateTime = inputFormat.parse(date);
      return DateFormat('EEEE').format(dateTime);
    } catch (e) {
      return 'N/A';
    }
  }

  static DateTime getDate({required String date}) {
    try {
      DateFormat dateFormat = DateFormat("dd-MMM-yyyy");
      return dateFormat.parse(date);
    } catch (e) {
      return DateTime.now();
    }
  }
}
