import 'package:intl/intl.dart';

String formatDateWithSuffix(String inputDate) {
  DateTime date = DateTime.parse(inputDate);
  String day = date.day.toString();
  String suffix = getDaySuffix(date.day);
  String month = DateFormat('MMMM').format(date);
  String year = date.year.toString();

  return "$day$suffix $month $year";
}

String getDaySuffix(int day) {
  if (day >= 11 && day <= 13) return 'th';
  switch (day % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}
