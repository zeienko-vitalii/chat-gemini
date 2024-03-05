// ignore_for_file: lines_longer_than_80_chars

import 'package:chat_gemini/utils/error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  MaterialApp buildTestApp(Widget child) {
    return MaterialApp(
      home: Scaffold(body: child),
    );
  }

  group('showSnackbarMessage', () {
    testWidgets(
        'displays "No message." and SnackBarThemeData.backgroundColor when no parameters are passed',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                onPressed: () => showSnackbarMessage(context),
                child: const Text('Show Snackbar'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify default text and default background color
      expect(find.text('No message.'), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (Widget widget) =>
              widget is SnackBar && widget.backgroundColor == Colors.redAccent,
        ),
        findsOneWidget,
      );
    });

    testWidgets(
        'displays the correct message and SnackBarThemeData.backgroundColor when message is passed',
        (WidgetTester tester) async {
      const testMessage = 'Test Message';

      await tester.pumpWidget(
        buildTestApp(
          Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                onPressed: () =>
                    showSnackbarMessage(context, message: testMessage),
                child: const Text('Show Snackbar'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify the passed message and default background color for error type
      expect(find.text(testMessage), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (Widget widget) =>
              widget is SnackBar && widget.backgroundColor == Colors.redAccent,
        ),
        findsOneWidget,
      );
    });

    testWidgets(
        'displays the message with Colors.redAccent background color when type is set to SnackbarMessageType.error',
        (WidgetTester tester) async {
      const errorMessage = 'Error Message';

      await tester.pumpWidget(
        buildTestApp(
          Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                onPressed: () => showSnackbarMessage(
                  context,
                  message: errorMessage,
                  type: SnackbarMessageType.error,
                ),
                child: const Text('Show Error Snackbar'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify error message and error background color
      expect(find.text(errorMessage), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (Widget widget) =>
              widget is SnackBar && widget.backgroundColor == Colors.redAccent,
        ),
        findsOneWidget,
      );
    });

    testWidgets(
        'displays the message with Colors.green background color when type is set to SnackbarMessageType.success',
        (WidgetTester tester) async {
      const successMessage = 'Success Message';

      await tester.pumpWidget(
        buildTestApp(
          Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                onPressed: () => showSnackbarMessage(
                  context,
                  message: successMessage,
                  type: SnackbarMessageType.success,
                ),
                child: const Text('Show Success Snackbar'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify success message and success background color
      expect(find.text(successMessage), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (Widget widget) =>
              widget is SnackBar && widget.backgroundColor == Colors.green,
        ),
        findsOneWidget,
      );
    });
  });
}
