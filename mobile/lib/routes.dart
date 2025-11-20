import 'package:flutter/material.dart';
import 'features/authentication/presentation/pages/register_page.dart';
import 'features/authentication/presentation/pages/login_page.dart';

class Routes {
  static const String register = "/register";
  static const String login = "/login";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());

      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Page not found")),
          ),
        );
    }
  }
}
