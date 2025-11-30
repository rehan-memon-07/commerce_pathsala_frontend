import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/theme_constants.dart';

class StudentAttendanceScreen extends StatefulWidget {
  const StudentAttendanceScreen({Key? key}) : super(key: key);

  @override
  State<StudentAttendanceScreen> createState() => _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: ThemeConstants.primaryDark,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ThemeConstants.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOverallAttendanceCard(),
              const SizedBox(height: ThemeConstants.lg),
              Text(
                'Subject-wise Attendance',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: ThemeConstants.md),
              _buildSubjectAttendanceList(),
              const SizedBox(height: ThemeConstants.lg),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverallAttendanceCard() {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overall Attendance',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: ThemeConstants.lg),
          Row(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: 0.85,
                      strokeWidth: 10,
                      valueColor: const AlwaysStoppedAnimation(
                        ThemeConstants.primaryBlue,
                      ),
                      backgroundColor: ThemeConstants.borderColor,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '85%',
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontSize: 28,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: ThemeConstants.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You have attended',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '170 out of 200 classes.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
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

  Widget _buildSubjectAttendanceList() {
    final subjects = [
      ('Mathematics', 0.92, ThemeConstants.mathColor),
      ('Chemistry', 0.78, ThemeConstants.chemistryColor),
      ('Physics', 0.55, ThemeConstants.errorColor),
      ('English Literature', 0.98, ThemeConstants.englishColor),
    ];

    return Column(
      children: subjects.asMap().entries.map((entry) {
        int index = entry.key;
        var subject = entry.value;
        return _buildSubjectCard(
          subject.$1,
          subject.$2,
          subject.$3,
          index,
        );
      }).toList(),
    );
  }

  Widget _buildSubjectCard(String subject, double percentage, Color color, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: ThemeConstants.md),
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
      padding: const EdgeInsets.all(ThemeConstants.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subject,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Text(
                '${(percentage * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: ThemeConstants.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percentage,
              minHeight: 8,
              backgroundColor: ThemeConstants.borderColor,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
          const SizedBox(height: ThemeConstants.sm),
          Text(
            'View Details',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ThemeConstants.primaryBlue,
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: (50 * index).ms)
        .slideY(begin: 0.2);
  }
}
