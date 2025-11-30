import 'package:flutter/material.dart';
import '../constants/theme_constants.dart';

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: ThemeConstants.primaryDark,
      ),
      body: Center(
        child: Text('Profile Screen - Coming Soon'),
      ),
    );
  }
}
