import 'package:chat_gemini/utils/date_time.utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isDifferenceMoreThanOneDay', () {
    test('returns true if difference of two days', () {
      final result = isDifferenceMoreThanOneDay(
        DateTime.now(),
        DateTime.now().subtract(
          const Duration(days: 2),
        ),
      );
      expect(result, true);
    });

    test('returns false difference of one day', () {
      var result = isDifferenceMoreThanOneDay(
        DateTime.now(),
        DateTime.now().subtract(
          const Duration(days: 1),
        ),
      );
      expect(result, false);
    });
  });

  group('formatDateTime', () {
    test('returns "Today" for Today\'s date', () {
      final result = formatDateTime(DateTime.now());
      expect(result, 'Today');
    });

    test('returns "Yesterday" Yesterday\'s date', () {
      final result = formatDateTime(
        DateTime.now().subtract(
          const Duration(days: 1),
        ),
      );
      expect(result, 'Yesterday');
    });

    test('returns formatted date without year for a date from this year', () {
      final date = DateTime.now().subtract(const Duration(days: 2));
      final result = formatDateTime(date);
      expect(result, '${date.day} ${months[date.month - 1]}');
    });

    test('returns formatted date with year for date from previous year', () {
      final date = DateTime.now().subtract(const Duration(days: 365));
      final result = formatDateTime(date);
      expect(result, '${date.day} ${months[date.month - 1]} ${date.year}');
    });
  });
}
