import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constants/theme_constants.dart';
import 'student_assignments.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({Key? key}) : super(key: key);

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int _selectedIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = const [
      StudentDashboardHome(),
      StudentCoursesScreen(),
      StudentGradesScreen(),
      StudentProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: ThemeConstants.primaryBlue,
        unselectedItemColor: ThemeConstants.textLight,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_rounded),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grade_rounded),
            label: 'Grades',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

/* ---------------- HOME ---------------- */

class StudentDashboardHome extends StatelessWidget {
  const StudentDashboardHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context, user),
            const SizedBox(height: ThemeConstants.lg),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: ThemeConstants.lg),
              child: Column(
                children: [
                  _buildAttendanceCard(context),
                  const SizedBox(height: ThemeConstants.lg),
                  _buildAssignments(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, User? user) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(ThemeConstants.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dashboard',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 4),
              Text(
                'Welcome back, ${user?.displayName ?? 'Student'}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const Icon(Icons.notifications_rounded),
        ],
      ),
    );
  }

  Widget _buildAttendanceCard(BuildContext context) {
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
          SizedBox(
            width: 90,
            height: 90,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: 0.92,
                  strokeWidth: 8,
                  valueColor:
                  AlwaysStoppedAnimation(ThemeConstants.primaryBlue),
                  backgroundColor: ThemeConstants.borderColor,
                ),
                Text(
                  '92%',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ),
          ),
          const SizedBox(width: ThemeConstants.lg),
          const Expanded(
            child: Text(
              'Great work! You have attended 92 out of 100 classes.',
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.2);
  }

  Widget _buildAssignments(BuildContext context) {
    final data = [
      {'title': 'Mathematics', 'count': 3, 'color': Color(0xFF3B82F6)},
      {'title': 'Science', 'count': 1, 'color': Color(0xFF10B981)},
      {'title': 'History', 'count': 5, 'color': Color(0xFF8B5CF6)},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('New Assignments',
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: ThemeConstants.md),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: ThemeConstants.md,
            mainAxisSpacing: ThemeConstants.md,
          ),
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];
            return InkWell(
              borderRadius:
              BorderRadius.circular(ThemeConstants.radiusMd),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const StudentAssignmentsScreen(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(ThemeConstants.md),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(ThemeConstants.radiusMd),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.assignment_rounded,
                        color: item['color'] as Color),
                    const Spacer(),
                    Text(item['title'] as String,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600)),
                    Text('${item['count']} new assignments'),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

/* ---------------- OTHER TABS ---------------- */

class StudentCoursesScreen extends StatelessWidget {
  const StudentCoursesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Courses – Coming Soon')),
    );
  }
}

class StudentGradesScreen extends StatelessWidget {
  const StudentGradesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Grades – Coming Soon')),
    );
  }
}

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({Key? key}) : super(key: key);

  Future<void> _logout() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user?.displayName ?? 'Student'),
            const SizedBox(height: 8),
            Text(user?.email ?? ''),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _logout,
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
