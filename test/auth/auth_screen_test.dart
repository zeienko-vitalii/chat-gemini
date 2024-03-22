import 'package:bloc_test/bloc_test.dart';
import 'package:chat_gemini/auth/auth_screen.dart';
import 'package:chat_gemini/auth/cubit/auth_cubit.dart';
import 'package:chat_gemini/auth/views/auth_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
  late MockAuthCubit mockAuthCubit;
  late Widget viewUnderTest;

  setUp(() {
    mockAuthCubit = MockAuthCubit();
    viewUnderTest = makeTestableWidget(mockAuthCubit);
  });

  group('AuthComponent', () {
    testWidgets('renders AuthComponent', (tester) async {
      when(() => mockAuthCubit.state).thenReturn(const AuthState.loading());
      when(() => mockAuthCubit.checkUserAuthStatus()).thenAnswer(
        (_) => Future.value(),
      );

      await tester.pumpWidget(viewUnderTest);

      expect(find.byType(AuthComponent), findsOneWidget);
    });
  });
}

Widget makeTestableWidget(AuthCubit authCubit) {
  return BlocProvider(
    create: (context) => authCubit,
    child: const MaterialApp(home: AuthScreen()),
  );
}
