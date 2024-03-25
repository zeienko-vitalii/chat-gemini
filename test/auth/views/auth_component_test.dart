// ignore_for_file: lines_longer_than_80_chars

import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:chat_gemini/app/navigation/app_router.dart';
import 'package:chat_gemini/auth/auth_screen.dart';
import 'package:chat_gemini/auth/cubit/auth_cubit.dart';
import 'package:chat_gemini/auth/data/auth_service.dart';
import 'package:chat_gemini/auth/data/repository/user_repository.dart';
import 'package:chat_gemini/auth/domain/models/user.dart';
import 'package:chat_gemini/auth/views/already_have_account/already_have_account.dart';
import 'package:chat_gemini/auth/views/auth_component.dart';
import 'package:chat_gemini/auth/views/email_auth_form.dart';
import 'package:chat_gemini/chat/data/repository/chat_repository.dart';
import 'package:chat_gemini/chat/data/repository/media_storage_repository.dart';
import 'package:chat_gemini/profile/cubit/profile_cubit.dart';
import 'package:chat_gemini/profile/data/repository/user_media_storage_repository.dart';
import 'package:chat_gemini/splash/cubit/splash_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

final getIt = GetIt.asNewInstance();

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

class MockProfileCubit extends MockCubit<ProfileState>
    implements ProfileCubit {}

class MockUserFirebase extends Mock implements auth.User {
  MockUserFirebase({required this.uid, this.email = ''});

  @override
  final String uid;

  @override
  final String email;
}

class MockUserRepository extends Mock implements UserRepository {}

class MockAuthService extends Mock implements AuthService {}

class MockChatScreenRoute extends Mock implements ChatScreenRoute {}

class MockUserMediaStorageRepository extends Mock
    implements UserMediaStorageRepository {}

class MockChatRepository extends Mock implements ChatRepository {}

class MockMediaStorageRepository extends Mock
    implements MediaStorageRepository {}

class MockScaffoldMessengerState extends Mock
    implements ScaffoldMessengerState {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MockScaffoldMessengerState;';
  }
}

class MockAppRouter extends AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          initial: true,
          page: AuthScreenRoute.page,
        ),
        AutoRoute(
          page: ChatScreenRoute.page,
        ),
        AutoRoute(
          page: ProfileScreenRoute.page,
        ),
      ];
}

void main() {
  late MockAuthCubit mockAuthCubit;
  late Widget viewUnderTest;
  late MockProfileCubit mockProfileCubit;

  setUpAll(() {
    mockProfileCubit = MockProfileCubit();
    when(() => mockProfileCubit.loadProfile()).thenAnswer(
      (_) => Future.value(),
    );
  });

  tearDownAll(getIt.reset);

  setUp(() {
    mockAuthCubit = MockAuthCubit();
    viewUnderTest = makeTestableWidget(mockAuthCubit);

    when(() => mockAuthCubit.state).thenReturn(const AuthState.loading());
    when(() => mockAuthCubit.checkUserAuthStatus()).thenAnswer(
      (_) => Future.value(),
    );
  });

  group(
    'AuthComponent',
    () {
      testWidgets("shows 'Sign Up' title", (tester) async {
        await tester.pumpWidget(viewUnderTest);

        // Find the AppBar widget
        final appBarFinder = find.byKey(const Key('signin_appbar'));

        final titleFinder = find.descendant(
          of: appBarFinder,
          matching: find.byType(Text),
        );

        expect(appBarFinder, findsOneWidget);
        expect(tester.widget<Text>(titleFinder).data, 'Sign Up');
      });

      testWidgets('shows 3 TextFields', (tester) async {
        await tester.pumpWidget(viewUnderTest);

        final textFields = find.byType(TextFormField);

        expect(textFields, findsExactly(3));
      });

      testWidgets('shows Confirm Password Text Field', (tester) async {
        await tester.pumpWidget(viewUnderTest);

        final confirmPasswordTextFieldFinder = find.byKey(
          const Key('confirm_password_text_field'),
        );

        expect(confirmPasswordTextFieldFinder, findsOneWidget);
      });

      testWidgets('shows Email Sign Up button', (tester) async {
        await tester.pumpWidget(viewUnderTest);

        final signInButton = find.byType(EmailSignInButton);

        final titleFinder = find.descendant(
          of: signInButton,
          matching: find.byType(Text),
        );

        expect(signInButton, findsOneWidget);
        expect(titleFinder, findsOneWidget);
        expect(tester.widget<Text>(titleFinder).data, 'Sign Up');
      });

      group('shows Google SignIn button', () {
        testWidgets('', (tester) async {
          await tester.pumpWidget(viewUnderTest);

          final googleSignInButton = find.byKey(
            const Key('google_sign_in_button'),
            skipOffstage: false,
          );

          expect(googleSignInButton, findsOneWidget);
        });

        testWidgets('and calls signInWithGoogle by pressing on it',
            (tester) async {
          when(() => mockAuthCubit.signInWithGoogle()).thenAnswer(
            (_) => Future.value(),
          );
          await tester.pumpWidget(makeTestableWidget(mockAuthCubit));

          final googleSignInButton = find.byKey(
            const Key('google_sign_in_button'),
            skipOffstage: false,
          );
          final listFinder = find.byType(Scrollable).last;

          expect(listFinder, findsOneWidget);

          await tester.dragUntilVisible(
            googleSignInButton,
            listFinder,
            Offset.zero,
          );
          await tester.pumpAndSettle();

          await tester.tap(googleSignInButton);
          await tester.pumpAndSettle();

          expect(googleSignInButton, findsOneWidget);
          verify(() => mockAuthCubit.signInWithGoogle()).called(1);
        });
      });

      testWidgets('shows Already Have An Account button', (tester) async {
        await tester.pumpWidget(viewUnderTest);

        const expectedTitle = 'Already have an account? Sign In';
        final alreadyHaveAnAccountButton = find.byType(AlreadyHaveAccount);

        final titleFinder = find.descendant(
          of: alreadyHaveAnAccountButton,
          matching: find.byType(Text),
        );
        expect(alreadyHaveAnAccountButton, findsOneWidget);
        expect(tester.widget<Text>(titleFinder).data, expectedTitle);
      });

      group(
        "changes state by pressing on 'Already Have An Account' button and",
        () {
          Future<void> switchToSignUpScreen(WidgetTester tester) async {
            final button = find.byKey(
              const Key('already_have_account_button'),
            );

            final listFinder = find.byType(Scrollable).last;

            await tester.dragUntilVisible(
              button,
              listFinder,
              Offset.zero,
            );
            await tester.pumpAndSettle();

            await tester.tap(button);
            await tester.pumpAndSettle();
          }

          testWidgets(
            'shows Sign In title in AppBar',
            (tester) async {
              const signIn = 'Sign In';

              await tester.pumpWidget(viewUnderTest);

              await switchToSignUpScreen(tester);

              final appBarFinder = find.byKey(const Key('signin_appbar'));

              final titleFinder = find.descendant(
                of: appBarFinder,
                matching: find.byType(Text),
              );

              expect(appBarFinder, findsOneWidget);
              expect(tester.widget<Text>(titleFinder).data, signIn);
            },
          );

          testWidgets("shows 'Need an account?' button", (tester) async {
            const expectedTitle = 'Need an account? Sign Up';

            await tester.pumpWidget(viewUnderTest);

            final alreadyHaveAnAccountButton = find.byKey(
              const Key('already_have_account_button'),
            );

            final listFinder = find.byType(Scrollable).last;

            await tester.dragUntilVisible(
              alreadyHaveAnAccountButton,
              listFinder,
              Offset.zero,
            );
            await tester.pumpAndSettle();

            await tester.tap(alreadyHaveAnAccountButton);
            await tester.pumpAndSettle();

            final titleFinder = find.descendant(
              of: alreadyHaveAnAccountButton,
              matching: find.byType(Text),
            );

            expect(alreadyHaveAnAccountButton, findsOneWidget);
            expect(tester.widget<Text>(titleFinder).data, expectedTitle);
          });

          testWidgets('shows 2 TextFields', (tester) async {
            await tester.pumpWidget(viewUnderTest);

            await switchToSignUpScreen(tester);

            final textFields = find.byType(TextFormField);

            expect(textFields, findsExactly(2));
          });

          testWidgets("doesn't show Confirm Password Text Field",
              (tester) async {
            await tester.pumpWidget(viewUnderTest);

            await switchToSignUpScreen(tester);

            final confirmPasswordTextFieldFinder = find.byKey(
              const Key('confirm_password_text_field'),
            );

            expect(confirmPasswordTextFieldFinder, findsNothing);
          });
        },
      );

      group('onAuthListener', skip: true, () {
        late AuthCubit authCubit;

        const fakeUser = User(
          uid: 'testId',
          email: '',
          name: '',
        );

        setUp(() {
          authCubit = AuthCubit(
            MockAuthService(),
            MockUserRepository(),
          );
        });

        testWidgets(
          'shows error snackbar when AuthError state',
          (tester) async {
            final testableView = makeTestableWidget(authCubit);
            await tester.pumpWidget(testableView);

            expect(find.byType(SnackBar), findsNothing);
            authCubit.emit(const AuthState.error('Error'));
            await tester.pump();
            expect(find.byType(SnackBar), findsOneWidget);
          },
        );

        testWidgets(
          'navigates to ProfileScreenRoute when SignedInIncomplete state',
          (tester) async {
            // arrange
            final mockedAuthService = MockAuthService();
            final mockedUserRepository = MockUserRepository();
            authCubit = AuthCubit(
              mockedAuthService,
              mockedUserRepository,
            );
            when(() => mockedAuthService.currentUser).thenReturn(
              MockUserFirebase(
                uid: '',
              ),
            );
            when(() => mockedUserRepository.getUser(any())).thenAnswer(
              (_) => Future.value(fakeUser),
            );
            final appAutoRouter = MockAppRouter();
            getIt.registerFactory<ProfileCubit>(() => mockProfileCubit);

            await pumpWidgetWithRoute(
              tester,
              appAutoRouter,
              authCubit: authCubit,
            );

            // act
            // authCubit.emit(
            //   AuthState.signedInComplete(fakeUser),
            // );
            await tester.pumpAndSettle(Durations.extralong4);

            // assert
            expectCurrentPage(appAutoRouter, 'ProfileScreenRoute');
          },
          timeout: const Timeout(Duration(seconds: 10)),
        );

        // testWidgets(
        //     'navigates to ProfileScreenRoute when SignedInIncomplete state',
        //     (tester) async {
        //   const state = SignedInIncomplete(
        //     User(uid: 'testId', email: '', name: ''),
        //   );
        //   final mockContext = MockBuildContext();

        //   when(() => mockContext.read<AuthCubit>()).thenReturn(mockAuthCubit);
        //   when(() => mockContext.router).thenReturn(MockRouter());

        //   onAuthListener(mockContext, state);

        //   verify(
        //     () => mockContext.router.replace(
        //       ProfileScreenRoute(toCompleteProfile: true),
        //     ),
        //   ).called(1);
        // });

        // testWidgets(
        //     'calls silentSignInWithGoogle when LogOut state and kIsWeb is true',
        //     (tester) async {
        //   const state = LogOut();
        //   final mockContext = MockBuildContext();

        //   when(() => mockContext.read<AuthCubit>()).thenReturn(mockAuthCubit);
        //   when(() => mockContext.router).thenReturn(MockRouter());

        //   onAuthListener(mockContext, state);

        //   verify(() => mockContext.read<AuthCubit>().silentSignInWithGoogle())
        //       .called(1);
        // });
      });
    },
  );

  group('titleByIsSignIn', () {
    test('returns "Sign In" when isSignIn is true', () {
      final result = titleByIsSignIn(isSignIn: true);
      expect(result, 'Sign In');
    });

    test('returns "Sign Up" when isSignIn is false', () {
      final result = titleByIsSignIn(isSignIn: false);
      expect(result, 'Sign Up');
    });
  });
}

Widget makeTestableWidget(
  AuthCubit authCubit, {
  AppRouter? router,
  SplashCubit? splashCubit,
}) {
  return MaterialApp(
    home: MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => authCubit),
        if (splashCubit != null)
          BlocProvider(
            create: (context) => splashCubit,
          ),
      ],
      child: const Scaffold(
        body: AuthScreen(),
      ),
    ),
  );
}

Future<void> pumpWidgetWithRoute(
  WidgetTester tester,
  AppRouter router, {
  AuthCubit? authCubit,
  SplashCubit? splashCubit,
}) {
  return tester.pumpWidget(
    MultiBlocProvider(
      providers: [
        if (authCubit != null)
          BlocProvider(
            create: (context) => authCubit,
          ),
        if (splashCubit != null)
          BlocProvider(
            create: (context) => splashCubit,
          ),
      ],
      child: MaterialApp.router(
        routerConfig: router.config(),
      ),
    ),
  );
}

void expectCurrentPage(StackRouter router, String name) {
  expect(router.current.name, name);
  // expect(find.text(name), findsOneWidget);
}
