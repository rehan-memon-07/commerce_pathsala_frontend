import 'package:commerce_paathshala_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'auth/auth_gate.dart';

Future<void> main() async {
  // 🔥 REQUIRED for Firebase + plugins
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const EduPlatformApp());
}

class EduPlatformApp extends StatelessWidget {
  const EduPlatformApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduPlatform',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,

        primaryColor: const Color(0xFF1F2937),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          brightness: Brightness.light,
        ),

        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
          displayMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
          headlineSmall: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2937),
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Color(0xFF4B5563),
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Color(0xFF6B7280),
          ),
        ),
      ),

      // 🔥 PERMANENT ROOT WIDGET
      home: const SplashScreen(),
    );
  }
}
