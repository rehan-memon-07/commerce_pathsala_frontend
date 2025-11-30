import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: ThemeConstants.primaryDark,
        leading: GestureDetector(
          onTap: () => setState(() => _sidebarOpen = !_sidebarOpen),
          child: const Icon(Icons.menu_rounded),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: ThemeConstants.lg),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(Icons.notifications_rounded),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          if (_sidebarOpen) _buildSidebar(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
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
                      () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const MarkAttendanceScreen()),
                      ),
                    ),
                    const SizedBox(height: ThemeConstants.md),
                    _buildQuickActionCard(
                      'Upload Assignment',
                      Icons.upload_rounded,
                      Color(0xFF10B981),
                      () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const NewAssignmentForm()),
                      ),
                    ),
                    const SizedBox(height: ThemeConstants.md),
                    _buildQuickActionCard(
                      'View Attendance Summary',
                      Icons.bar_chart_rounded,
                      Color(0xFF8B5CF6),
                      () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 250,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: ThemeConstants.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: ThemeConstants.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: ThemeConstants.primaryBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: ThemeConstants.md),
                Text(
                  'Mrs. Davison',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  'Teacher',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const Divider(height: ThemeConstants.lg),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
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
    return ListTile(
      leading: Icon(
        icon,
        color: _selectedIndex == index ? ThemeConstants.primaryBlue : ThemeConstants.textLight,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: _selectedIndex == index ? ThemeConstants.primaryBlue : ThemeConstants.textMedium,
          fontWeight: _selectedIndex == index ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
      onTap: () => setState(() => _selectedIndex = index),
    );
  }

  Widget _buildGreetingCard() {
    return Container(
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
      padding: const EdgeInsets.all(ThemeConstants.lg),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFFFBB75F).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.waving_hand_rounded,
              color: Color(0xFFFBB75F),
              size: 32,
            ),
          ),
          const SizedBox(width: ThemeConstants.lg),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Morning, Mrs. Davison',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                'Tuesday, 24 October',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.2);
  }

  Widget _buildQuickActionCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
        padding: const EdgeInsets.all(ThemeConstants.lg),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),
            const SizedBox(width: ThemeConstants.lg),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: ThemeConstants.textLight,
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.2);
  }
}
