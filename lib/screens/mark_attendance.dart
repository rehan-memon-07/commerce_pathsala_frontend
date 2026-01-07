import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/theme_constants.dart';
import '../models/attendance_model.dart';
import '../models/user_model.dart';

class MarkAttendanceScreen extends StatefulWidget {
  const MarkAttendanceScreen({Key? key}) : super(key: key);

  @override
  State<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  String _selectedClass = 'Class 10 - A';
  String _selectedSubject = 'Mathematics';
  DateTime _selectedDate = DateTime.now();

  late final List<Attendance> _students = [
    Attendance(
      id: '1',
      studentId: '1',
      studentName: 'Ananya Sharma',
      subject: _selectedSubject,
      className: _selectedClass,
      date: _selectedDate,
      isPresent: true,
    ),
    Attendance(
      id: '2',
      studentId: '2',
      studentName: 'Rohan Verma',
      subject: _selectedSubject,
      className: _selectedClass,
      date: _selectedDate,
      isPresent: false,
    ),
    Attendance(
      id: '3',
      studentId: '3',
      studentName: 'Priya Singh',
      subject: _selectedSubject,
      className: _selectedClass,
      date: _selectedDate,
      isPresent: true,
    ),
    Attendance(
      id: '4',
      studentId: '4',
      studentName: 'Vikram Rathore',
      subject: _selectedSubject,
      className: _selectedClass,
      date: _selectedDate,
      isPresent: false,
    ),
    Attendance(
      id: '5',
      studentId: '5',
      studentName: 'Aisha Khan',
      subject: _selectedSubject,
      className: _selectedClass,
      date: _selectedDate,
      isPresent: false,
    ),

  ];

  void _toggleAttendance(int index) {
    setState(() {
      final current = _students[index];
      _students[index] = Attendance(
        id: current.id,
        studentId: current.studentId,
        studentName: current.studentName,
        subject: current.subject,
        className: current.className,
        date: current.date,
        isPresent: !current.isPresent,
        remarks: current.remarks,
      );

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mark Attendance'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: ThemeConstants.primaryDark,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderIllustration(),
            Padding(
              padding: const EdgeInsets.all(ThemeConstants.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFormSection(),
                  const SizedBox(height: ThemeConstants.lg),
                  _buildStudentList(),
                  const SizedBox(height: ThemeConstants.lg),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderIllustration() {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ThemeConstants.primaryBlue.withOpacity(0.1),
            ThemeConstants.primaryBlue.withOpacity(0.05),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: ThemeConstants.primaryBlue.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.assignment_turned_in_rounded,
                  size: 50,
                  color: ThemeConstants.primaryBlue,
                ),
              ),
            )
                .animate()
                .fadeIn(duration: 600.ms)
                .scale(),
          ],
        ),
      ),
    );
  }

  Widget _buildFormSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDropdownField('Class', _selectedClass, ['Class 10 - A', 'Class 10 - B']),
        const SizedBox(height: ThemeConstants.lg),
        _buildDropdownField('Subject', _selectedSubject, ['Mathematics', 'Science', 'English']),
        const SizedBox(height: ThemeConstants.lg),
        _buildDateField(),
      ],
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.2);
  }

  Widget _buildDropdownField(String label, String value, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: ThemeConstants.sm),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: ThemeConstants.borderColor),
            borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
          ),
          padding: const EdgeInsets.symmetric(horizontal: ThemeConstants.md),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            underline: const SizedBox(),
            items: options.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                if (label == 'Class') _selectedClass = newValue!;
                if (label == 'Subject') _selectedSubject = newValue!;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: ThemeConstants.sm),
        GestureDetector(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: _selectedDate,
              firstDate: DateTime(2020),
              lastDate: DateTime(2025),
            );
            if (picked != null) setState(() => _selectedDate = picked);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: ThemeConstants.borderColor),
              borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: ThemeConstants.md,
              vertical: ThemeConstants.md,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Icon(Icons.calendar_today_rounded, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStudentList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mark Students',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: ThemeConstants.md),
        ...List.generate(
          _students.length,
          (index) => _buildStudentToggleCard(index),
        ),
      ],
    );
  }

  Widget _buildStudentToggleCard(int index) {
    final student = _students[index];
    return Container(
      margin: const EdgeInsets.only(bottom: ThemeConstants.md),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: student.isPresent ? ThemeConstants.successColor.withOpacity(0.2) : ThemeConstants.borderColor,
        ),
        borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
      ),
      padding: const EdgeInsets.all(ThemeConstants.md),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: ThemeConstants.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.person_rounded,
              color: ThemeConstants.primaryBlue,
            ),
          ),
          const SizedBox(width: ThemeConstants.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.studentName,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  'Roll No: ${student.studentId}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _toggleAttendance(index),
            child: Container(
              width: 50,
              height: 30,
              decoration: BoxDecoration(
                color: student.isPresent ? ThemeConstants.successColor : Colors.grey[300],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Align(
                alignment: student.isPresent ? Alignment.centerRight : Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: (50 * index).ms)
        .slideY(begin: 0.2);
  }

  Widget _buildSubmitButton() {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Attendance submitted successfully!'),
            backgroundColor: ThemeConstants.successColor,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(ThemeConstants.lg),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 56,
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Attendance submitted successfully!'),
                  backgroundColor: ThemeConstants.successColor,
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(ThemeConstants.lg),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
                  ),
                ),
              );
              Navigator.of(context).pop();
            },
            child: const Center(
              child: Text(
                'Submit Attendance',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.3);
  }
}
