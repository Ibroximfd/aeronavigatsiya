import 'package:aeronavigatsiya/presentation/students/blocs/bloc/student_main_bloc.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/auth/auth_bloc.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/home/home_bloc.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/library/library_bloc.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/privacy/privacy_bloc.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/splash/splash_bloc.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/splash/splash_event.dart';
import 'package:aeronavigatsiya/firebase_options.dart';
import 'package:aeronavigatsiya/presentation/teachers/screens/splash/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_update/in_app_update.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // 2 soniya kutib update tekshirish
    Future.delayed(const Duration(seconds: 2), () {
      _checkForUpdate();
    });
  }

  Future<void> _checkForUpdate() async {
    try {
      AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();

      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        if (mounted) {
          _showUpdateDialog(updateInfo);
        }
      }
    } catch (e) {
      debugPrint('Update check error: $e');
    }
  }

  void _showUpdateDialog(AppUpdateInfo updateInfo) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('🎉 Yangilanish mavjud!'),
        content: const Text(
          'Ilovaning yangi versiyasi chiqdi.\nYangi funksiyalar va tuzatishlar mavjud.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Keyinroq'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              if (updateInfo.immediateUpdateAllowed) {
                await InAppUpdate.performImmediateUpdate();
              } else if (updateInfo.flexibleUpdateAllowed) {
                await InAppUpdate.startFlexibleUpdate();
                await InAppUpdate.completeFlexibleUpdate();
              }
            },
            child: const Text('Yangilash'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SplashBloc()..add(CheckPrivacyAccepted())),
        BlocProvider(create: (_) => PrivacyBloc()),
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(create: (_) => LibraryBloc()),
        BlocProvider(create: (_) => StudentMainBloc()),
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
            supportedLocales: const [Locale('en', 'US')],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              quill.FlutterQuillLocalizations.delegate,
            ],
            home: const SplashPage(),
          );
        },
      ),
    );
  }
}
