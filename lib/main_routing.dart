import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/student_dashboard.dart';
import 'screens/teacher_dashboard.dart';

Map<String, WidgetBuilder> getRoutes() {
  return {
    '/': (context) => const SplashScreen(),
    '/signin': (context) => const SignInScreen(),
    '/onboarding': (context) => const OnboardingScreen(),
    '/student': (context) => const StudentDashboard(),
    '/teacher': (context) => const TeacherDashboard(),
  };
}
