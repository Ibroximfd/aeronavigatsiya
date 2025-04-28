import 'package:aviatoruz/core/router/app_router_name.dart';
import 'package:aviatoruz/presentation/teachers/screens/splash/splash_page.dart';
import 'package:flutter/material.dart';

@immutable
final class AppRouter<T extends Object?> {
  Route<T> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteName.splashPage:
        return MaterialPageRoute<T>(
          builder: (context) => const SplashPage(),
          settings: settings,
        );

      default:
        return _errorRoute();
    }
  }

  Route<T> _errorRoute() => MaterialPageRoute<T>(
        builder: (context) => Scaffold(
          body: Center(
            child: Text(
              'Error Route',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.white),
            ),
          ),
        ),
      );
}
