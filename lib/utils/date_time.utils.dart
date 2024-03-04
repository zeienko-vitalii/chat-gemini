bool isDifferenceMoreThanOneDay(DateTime date1, DateTime date2) {
  return (date1.day - date2.day).abs() > 1;
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
    return '${dateTime.day} ${months[dateTime.month - 1]}';
  } else {
    return '${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year}';
  }
}

final months = [
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
