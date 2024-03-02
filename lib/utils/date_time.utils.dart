bool isDifferenceMoreThanOneDay(DateTime date1, DateTime date2) {
  return date1.difference(date2).inDays > 1;
}

String formatDateTime(DateTime dateTime) {
  final now = DateTime.now();
  final isToday = now.day == dateTime.day;
  final isYesterday = now.day - dateTime.day == 1;
  final isThisYear = now.year == dateTime.year;

  if (isToday) {
    return 'Today';
  } else if (isYesterday) {
    return 'Yesterday';
  } else if (isThisYear) {
    return '${dateTime.day} ${_months[dateTime.month - 1]}';
  } else {
    return '${dateTime.day} ${_months[dateTime.month - 1]} ${dateTime.year}';
  }
}

final _months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];