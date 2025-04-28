import 'package:aviatoruz/presentation/teachers/bloc/auth/auth_bloc.dart';
import 'package:aviatoruz/presentation/teachers/bloc/home/home_bloc.dart';
import 'package:aviatoruz/presentation/teachers/bloc/library/library_bloc.dart';
import 'package:aviatoruz/presentation/teachers/bloc/privacy/privacy_bloc.dart';
import 'package:aviatoruz/presentation/teachers/bloc/splash/splash_bloc.dart';
import 'package:aviatoruz/presentation/teachers/bloc/splash/splash_event.dart';
import 'package:aviatoruz/firebase_options.dart';
import 'package:aviatoruz/presentation/teachers/screens/auth/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart'; // For Quill localizations
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SplashBloc()..add(CheckPrivacyAccepted())),
        BlocProvider(create: (_) => PrivacyBloc()),
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(create: (_) => LibraryBloc()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 930),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                useMaterial3: true,
                appBarTheme: const AppBarTheme(),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              // Add localization support for FlutterQuill and other Flutter widgets
              supportedLocales: const [
                Locale('uz', 'UZ'), // Uzbek
                Locale('en', 'US'), // English as fallback
              ],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                FlutterQuillLocalizations
                    .delegate, // Fixes the Quill localization error
              ],
              home: AuthGate());
        },
      ),
    );
  }
}
