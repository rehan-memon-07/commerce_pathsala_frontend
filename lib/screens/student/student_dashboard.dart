// ============================================================================
// STUDENT DASHBOARD SCREEN
// ============================================================================
// Main student home screen showing:
// - User greeting and profile
// - Attendance percentage
// - Recent assignments with status
// - Bottom navigation for multiple sections

import 'package:flutter/material.dart';
import "package:commerce_paathshala_app/provider/provider.dart";
import 'package:commerce_paathshala_app/config/theme_config.dart';
import 'package:commerce_paathshala_app/providers/student_provider.dart';
import 'package:commerce_paathshala_app/providers/auth_provider.dart';
import 'package:commerce_paathshala_app/screens/student/student_assignments.dart';
import 'package:commerce_paathshala_app/screens/student/student_attendance.dart';
import 'package:provider/provider.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({Key? key}) : super(key: key);

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int _selectedNavIndex = 0;

  @override
  void initState() {
    super.initState();
    // Load student data when screen initializes
    _loadStudentData();
  }

  /// Load all student data
  /// TODO: Get actual studentId from AuthProvider.currentUser
  void _loadStudentData() {
    final studentProvider = context.read<StudentProvider>();
    studentProvider.loadAssignments('student_001');
    studentProvider.loadAttendance('student_001');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: Navigate to notifications screen
            },
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedNavIndex,
        onTap: (index) {
          setState(() => _selectedNavIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Assignments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedNavIndex) {
      case 0:
        return _buildDashboardContent();
      case 1:
        return const StudentAssignmentsScreen();
      case 2:
        return const StudentAttendanceScreen();
      case 3:
        return _buildProfileContent();
      default:
        return _buildDashboardContent();
    }
  }

  Widget _buildDashboardContent() {
    return Consumer2<AuthProvider, StudentProvider>(
      builder: (context, authProvider, studentProvider, _) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User greeting
              Text(
                'Good Morning, ${authProvider.currentUser?.name.split(' ').first}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                'Tuesday, 24 October',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              // Attendance card
              if (studentProvider.attendanceStats != null)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ThemeConfig.lightBlueBackground,
                          ),
                          child: Center(
                            child: Text(
                              '${studentProvider.attendanceStats!.overallPercentage.toStringAsFixed(0)}%',
                              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: ThemeConfig.primaryBlue,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Attendance',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${studentProvider.attendanceStats!.classesAttended}/${studentProvider.attendanceStats!.totalClasses} classes',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 24),
              // Recent assignments section
              Text(
                'Recent Assignments',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              if (studentProvider.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (studentProvider.assignments.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text(
                      'No assignments yet',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                )
              else
                Column(
                  children: studentProvider.assignments.take(3).map((assignment) {
                    return _buildAssignmentCard(context, assignment);
                  }).toList(),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAssignmentCard(BuildContext context, dynamic assignment) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: ThemeConfig.lightBlueBackground,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text('📋', style: TextStyle(fontSize: 24)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        assignment.title,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        assignment.subject,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: ThemeConfig.getSubjectColor(assignment.subject),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Due: ${assignment.dueDate.toString().split(' ')[0]}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Navigate to assignment details
                  },
                  child: const Text('View'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileContent() {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              // Profile Avatar
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: ThemeConfig.lightBlueBackground,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    authProvider.currentUser?.name.substring(0, 1) ?? 'U',
                    style: TextStyle(fontSize: 48),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // User Info
              Text(
                authProvider.currentUser?.name ?? 'User',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                authProvider.currentUser?.email ?? '',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              // Logout Button
              ElevatedButton(
                onPressed: () {
                  authProvider.logout();
                  // TODO: Navigate to sign-in screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text('Logout'),
              ),
            ],
          ),
        );
      },
    );
  }
}
