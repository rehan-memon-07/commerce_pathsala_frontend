import 'package:flutter/material.dart';

class ThemeConstants {
  // Primary Colors
  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color primaryDark = Color(0xFF1F2937);
  static const Color primaryLight = Color(0xFFF8FAFC);

  // Subject Colors
  static const Color mathColor = Color(0xFF3B82F6);
  static const Color scienceColor = Color(0xFF10B981);
  static const Color historyColor = Color(0xFF8B5CF6);
  static const Color englishColor = Color(0xFFF59E0B);
  static const Color biologyColor = Color(0xFF06B6D4);
  static const Color chemistryColor = Color(0xFFEF4444);

  // Status Colors
  static const Color successColor = Color(0xFF22C55E);
  static const Color warningColor = Color(0xFFFBBF24);
  static const Color errorColor = Color(0xFFEF4444);
  static const Color infoColor = Color(0xFF3B82F6);

  // Neutral Colors
  static const Color textDark = Color(0xFF1F2937);
  static const Color textMedium = Color(0xFF6B7280);
  static const Color textLight = Color(0xFF9CA3AF);
  static const Color borderColor = Color(0xFFE5E7EB);
  static const Color backgroundColor = Color(0xFFF9FAFB);

  // Spacing
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;

  // Border Radius
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
}

Color getSubjectColor(String subject) {
  switch (subject.toLowerCase()) {
    case 'mathematics':
    case 'math':
      return ThemeConstants.mathColor;
    case 'science':
      return ThemeConstants.scienceColor;
    case 'history':
      return ThemeConstants.historyColor;
    case 'english':
    case 'english literature':
      return ThemeConstants.englishColor;
    case 'biology':
      return ThemeConstants.biologyColor;
    case 'chemistry':
      return ThemeConstants.chemistryColor;
    default:
      return ThemeConstants.primaryBlue;
  }
}
