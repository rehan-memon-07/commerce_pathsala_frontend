// ============================================================================
// TEACHER DASHBOARD SCREEN
// ============================================================================
// Main teacher home screen with:
// - Quick action cards (Mark Attendance, Upload Assignment, etc.)
// - Student statistics
// - Recent activity

import 'package:flutter/material.dart';
import "package:commerce_paathshala_app/provider/provider.dart";
import 'package:commerce_paathshala_app/config/theme_config.dart';
import 'package:commerce_paathshala_app/providers/auth_provider.dart';
import 'package:commerce_paathshala_app/screens/teacher/mark_attendance_screen.dart';
import 'package:commerce_paathshala_app/screens/teacher/new_assignment_screen.dart';
import 'package:provider/provider.dart';

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({Key? key}) : super(key: key);

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: Navigate to notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // TODO: Open drawer/menu
            },
          ),
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User greeting
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: ThemeConfig.lightBlueBackground,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          authProvider.currentUser?.name.substring(0, 1) ?? 'T',
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good Morning,',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            authProvider.currentUser?.name ?? 'Teacher',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // Quick Actions
                Text(
                  'Quick Actions',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                _buildActionCard(
                  context,
                  icon: '✓',
                  title: 'Mark Attendance',
                  description: 'Record class attendance',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const MarkAttendanceScreen(),
                      ),
                    );
                  },
                ),
                _buildActionCard(
                  context,
                  icon: '📤',
                  title: 'Create Assignment',
                  description: 'Upload new assignment',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const NewAssignmentScreen(),
                      ),
                    );
                  },
                ),
                _buildActionCard(
                  context,
                  icon: '📊',
                  title: 'View Attendance Summary',
                  description: 'Check class statistics',
                  onTap: () {
                    // TODO: Navigate to attendance summary
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required String icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: ThemeConfig.lightBlueBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(icon, style: const TextStyle(fontSize: 28)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: ThemeConfig.darkGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
