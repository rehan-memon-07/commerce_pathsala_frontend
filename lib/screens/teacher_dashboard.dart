import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constants/theme_constants.dart';
import 'mark_attendance.dart';
import 'new_assignment_form.dart';

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({Key? key}) : super(key: key);

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  int _selectedIndex = 0;
  bool _sidebarOpen = false;

  /// 🔥 PERMANENT LOGOUT
  Future<void> _logout() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    // AuthGate will redirect automatically
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Dashboard'),
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded),
          onPressed: () => setState(() => _sidebarOpen = !_sidebarOpen),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: _logout,
          ),
        ],
      ),
      body: Row(
        children: [
          if (_sidebarOpen) _buildSidebar(user),
          Expanded(child: _buildMainContent()),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(ThemeConstants.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGreetingCard(),
          const SizedBox(height: ThemeConstants.lg),

          _buildQuickActionCard(
            'Mark Attendance',
            Icons.check_circle_rounded,
            ThemeConstants.primaryBlue,
                () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MarkAttendanceScreen()),
            ),
          ),

          const SizedBox(height: ThemeConstants.md),

          _buildQuickActionCard(
            'Upload Assignment',
            Icons.upload_rounded,
            const Color(0xFF10B981),
                () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NewAssignmentForm()),
            ),
          ),

          const SizedBox(height: ThemeConstants.md),

          _buildQuickActionCard(
            'View Attendance Summary',
            Icons.bar_chart_rounded,
            const Color(0xFF8B5CF6),
                () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(User? user) {
    return Container(
      width: 250,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: ThemeConstants.lg),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: ThemeConstants.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: ThemeConstants.primaryBlue,
                  child: Text(
                    user?.displayName?.substring(0, 1) ?? 'T',
                    style: const TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
                const SizedBox(height: ThemeConstants.md),
                Text(
                  user?.displayName ?? 'Teacher',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  user?.email ?? '',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const Divider(height: ThemeConstants.lg),
          Expanded(
            child: ListView(
              children: [
                _buildSidebarItem('Dashboard', Icons.home_rounded, 0),
                _buildSidebarItem('Classes', Icons.class_rounded, 1),
                _buildSidebarItem('Assignments', Icons.assignment_rounded, 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(String title, IconData icon, int index) {
    final isSelected = _selectedIndex == index;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected
            ? ThemeConstants.primaryBlue
            : ThemeConstants.textLight,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected
              ? ThemeConstants.primaryBlue
              : ThemeConstants.textMedium,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
      onTap: () => setState(() => _selectedIndex = index),
    );
  }

  Widget _buildGreetingCard() {
    return Container(
      padding: const EdgeInsets.all(ThemeConstants.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ThemeConstants.radiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFFBB75F).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.waving_hand_rounded,
              color: Color(0xFFFBB75F),
              size: 28,
            ),
          ),
          const SizedBox(width: ThemeConstants.lg),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back!',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                'Have a productive day',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.2);
  }

  Widget _buildQuickActionCard(
      String title,
      IconData icon,
      Color color,
      VoidCallback onTap,
      ) {
    return InkWell(
      borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(ThemeConstants.lg),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: ThemeConstants.lg),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 16),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.2);
  }
}
