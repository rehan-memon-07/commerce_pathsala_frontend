import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/theme_constants.dart';
import 'student_dashboard.dart';
import 'teacher_dashboard.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: ThemeConstants.lg,
              vertical: ThemeConstants.lg,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentPage > 0)
                  GestureDetector(
                    onTap: () => _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ),
                    child: const Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 16,
                        color: ThemeConstants.primaryBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                else
                  const SizedBox(width: 50),
                Row(
                  children: List.generate(
                    2,
                    (index) => Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == _currentPage
                            ? ThemeConstants.primaryBlue
                            : ThemeConstants.borderColor,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 16,
                      color: ThemeConstants.textLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (page) => setState(() => _currentPage = page),
              children: [
                _buildOnboardingPage(
                  title: 'Empowering Educators',
                  description: 'Streamline attendance, create assignments, and track student progress effortlessly.',
                  icon: Icons.people_rounded,
                  features: [
                    'Mark Attendance',
                    'Upload Assignments',
                    'Communicate with Parents',
                    'Track Student Progress',
                  ],
                  isTeacher: true,
                ),
                _buildOnboardingPage(
                  title: 'Your Learning Journey',
                  description: 'Track your attendance, view assignments, and access all your course materials.',
                  icon: Icons.book_rounded,
                  features: [
                    'Track Attendance',
                    'View Assignments',
                    'Access Course Materials',
                    'Monitor Progress',
                  ],
                  isTeacher: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage({
    required String title,
    required String description,
    required IconData icon,
    required List<String> features,
    required bool isTeacher,
  }) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: ThemeConstants.lg),
        child: Column(
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: ThemeConstants.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 100,
                  color: ThemeConstants.primaryBlue,
                ),
              ),
            )
                .animate()
                .fadeIn(duration: 600.ms)
                .scale(),
            const SizedBox(height: 32),
            Text(
              title,
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,
            )
                .animate()
                .fadeIn(duration: 600.ms)
                .slide(begin: const Offset(0, 0.3)),
            const SizedBox(height: 12),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ThemeConstants.textMedium,
              ),
              textAlign: TextAlign.center,
            )
                .animate()
                .fadeIn(duration: 700.ms)
                .slide(begin: const Offset(0, 0.3)),
            const SizedBox(height: 32),
            ...features.map((feature) => _buildFeatureItem(feature)),
            const SizedBox(height: 40),
            _buildActionButton(isTeacher),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: const EdgeInsets.only(bottom: ThemeConstants.md),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: ThemeConstants.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Icon(
                Icons.check_rounded,
                color: ThemeConstants.primaryBlue,
                size: 18,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              feature,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideX();
  }

  Widget _buildActionButton(bool isTeacher) {
    return GestureDetector(
      onTap: () {
        if (isTeacher) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const TeacherDashboard()),
          );

        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const StudentDashboard()),
          );
        }
      },
      child: Container(
        height: 56,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ThemeConstants.primaryBlue,
          borderRadius: BorderRadius.circular(ThemeConstants.radiusLg),
          boxShadow: [
            BoxShadow(
              color: ThemeConstants.primaryBlue.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              if (isTeacher) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const TeacherDashboard()),
                );
              } else {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const StudentDashboard()),
                );
              }
            },
            child: Center(
              child: Text(
                isTeacher ? 'Sign in as Teacher' : 'Sign in as Student',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
