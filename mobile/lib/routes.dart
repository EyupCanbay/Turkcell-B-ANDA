import 'package:bi_anda/features/course_detail/presentation/pages/course_detail_page.dart';
import 'package:bi_anda/main_navigation.dart';
import 'package:flutter/material.dart';
import 'features/authentication/presentation/pages/login_page.dart';
import 'features/authentication/presentation/pages/register_page.dart';

class Routes {
  static const String register = "/register";
  static const String login = "/login";
  static const String main = "/main";
  static const String courseDetail = "/course-detail";
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());

      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case main:
        return MaterialPageRoute(builder: (_) => const MainNavigationPage());

      case courseDetail:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => CourseDetailPage(courseId: id),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Page not found")),
          ),
        );
    }
  }
}
