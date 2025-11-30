// ============================================================================
// MARK ATTENDANCE SCREEN
// ============================================================================
// Form for teachers to mark attendance for a class
// TODO: Add date picker, class/subject dropdowns
// TODO: Implement toggle for each student

import 'package:flutter/material.dart';
import "package:commerce_paathshala_app/provider/provider.dart";
import 'package:commerce_paathshala_app/config/theme_config.dart';
import 'package:commerce_paathshala_app/providers/teacher_provider.dart';
import 'package:provider/provider.dart';

class MarkAttendanceScreen extends StatefulWidget {
  const MarkAttendanceScreen({Key? key}) : super(key: key);

  @override
  State<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  String? _selectedClass;
  String? _selectedSubject;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Load attendance data when screen initializes
    _loadAttendanceData();
  }

  /// Load class attendance data
  /// TODO: Get actual classId and date from selected values
  void _loadAttendanceData() {
    final teacherProvider = context.read<TeacherProvider>();
    // teacherProvider.loadClassAttendance('class_001', _selectedDate);
  }

  /// Handle mark attendance submission
  /// TODO: Validate selected class and subject before marking
  /// TODO: Ensure at least some students are selected
  Future<void> _markAttendance() async {
    final teacherProvider = context.read<TeacherProvider>();
    
    // TODO: Validate form
    if (_selectedClass == null || _selectedSubject == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select class and subject')),
      );
      return;
    }

    final success = await teacherProvider.markAttendance(
      teacherProvider.currentClassAttendance,
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Attendance marked successfully')),
      );
      Navigator.of(context).pop();
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to mark attendance')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mark Attendance'),
      ),
      body: Consumer<TeacherProvider>(
        builder: (context, teacherProvider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Illustration
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: ThemeConfig.lightBlueBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text('📋', style: TextStyle(fontSize: 100)),
                  ),
                ),
                const SizedBox(height: 24),
                // Class Selection
                Text(
                  'Class',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedClass,
                  hint: const Text('Select a class'),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: ['Class 10 - A', 'Class 10 - B', 'Class 11 - A']
                      .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      ))
                      .toList(),
                  onChanged: (value) {
                    setState(() => _selectedClass = value);
                    // TODO: Load students for selected class
                  },
                ),
                const SizedBox(height: 16),
                // Subject Selection
                Text(
                  'Subject',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedSubject,
                  hint: const Text('Select a subject'),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: ['Mathematics', 'Science', 'English', 'History']
                      .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      ))
                      .toList(),
                  onChanged: (value) {
                    setState(() => _selectedSubject = value);
                  },
                ),
                const SizedBox(height: 16),
                // Date Selection
                Text(
                  'Date',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () async {
                    // TODO: Show date picker
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_selectedDate.toString().split(' ')[0]),
                        const Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Student List
                Text(
                  'Students',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 12),
                if (teacherProvider.currentClassAttendance.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text(
                        'Select class and subject to load students',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  )
                else
                  Column(
                    children: teacherProvider.currentClassAttendance
                        .map((attendance) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: ThemeConfig.lightBlueBackground,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                attendance.studentName.substring(0, 1),
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          title: Text(attendance.studentName),
                          subtitle: Text('Roll No: ${attendance.studentId}'),
                          trailing: Switch(
                            value: attendance.isPresent,
                            onChanged: (_) {
                              teacherProvider.toggleStudentAttendance(
                                attendance.id,
                              );
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                const SizedBox(height: 24),
                // Submit Button
                ElevatedButton(
                  onPressed: teacherProvider.isLoading
                      ? null
                      : _markAttendance,
                  child: teacherProvider.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              ThemeConfig.white,
                            ),
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Submit Attendance'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
