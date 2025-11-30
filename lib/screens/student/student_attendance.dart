// ============================================================================
// STUDENT ATTENDANCE SCREEN
// ============================================================================
// Shows overall attendance percentage, subject-wise breakdown, and history

import 'package:flutter/material.dart';
import "package:commerce_paathshala_app/provider/provider.dart";
import 'package:commerce_paathshala_app/config/theme_config.dart';
import 'package:commerce_paathshala_app/providers/student_provider.dart';
import 'package:provider/provider.dart';

class StudentAttendanceScreen extends StatelessWidget {
  const StudentAttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
      ),
      body: Consumer<StudentProvider>(
        builder: (context, studentProvider, _) {
          if (studentProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (studentProvider.attendanceStats == null) {
            return Center(
              child: Text(
                'No attendance data available',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }

          final stats = studentProvider.attendanceStats!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Overall Attendance Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Overall Attendance',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ThemeConfig.lightBlueBackground,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${stats.overallPercentage.toStringAsFixed(0)}%',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
                                        color: ThemeConfig.primaryBlue,
                                        fontSize: 36,
                                      ),
                                ),
                                Text(
                                  '${stats.classesAttended}/${stats.totalClasses}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: stats.overallPercentage / 100,
                            minHeight: 8,
                            backgroundColor: ThemeConfig.mediumGrey,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              ThemeConfig.successGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Subject-wise Attendance
                Text(
                  'Subject-wise Attendance',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 12),
                ...stats.subjectWisePercentage.entries.map((entry) {
                  final color = ThemeConfig.getSubjectColor(entry.key);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  entry.key,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  '${entry.value.toStringAsFixed(0)}%',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: color,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                value: entry.value / 100,
                                minHeight: 8,
                                backgroundColor: ThemeConfig.mediumGrey,
                                valueColor: AlwaysStoppedAnimation<Color>(color),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
