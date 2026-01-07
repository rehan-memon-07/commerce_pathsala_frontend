import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../constants/theme_constants.dart';
import '../models/assignment_model.dart';
import '../models/user_model.dart';

class StudentAssignmentsScreen extends StatefulWidget {
  const StudentAssignmentsScreen({Key? key}) : super(key: key);

  @override
  State<StudentAssignmentsScreen> createState() =>
      _StudentAssignmentsScreenState();
}

class _StudentAssignmentsScreenState extends State<StudentAssignmentsScreen> {
  String _selectedFilter = 'all';

  final List<Assignment> _assignments = [
    Assignment(
      id: '1',
      title: 'History Essay: The Roman Empire',
      description: 'Write a comprehensive essay about the Roman Empire',
      subject: 'History',
      teacherName: 'Mr. Johnson',
      dueDate: DateTime.now().subtract(const Duration(days: 3)),
      status: 'overdue',
      attachmentUrl: null,
      marks: null,
      grade: null,
      feedback: null,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
    Assignment(
      id: '2',
      title: 'Chapter 5 Reading Quiz',
      description: 'Complete the reading quiz on Chapter 5',
      subject: 'Biology',
      teacherName: 'Mrs. Smith',
      dueDate: DateTime.now().add(const Duration(days: 3)),
      status: 'pending',
      attachmentUrl: null,
      marks: null,
      grade: null,
      feedback: null,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Assignment(
      id: '3',
      title: 'Algebra Problem Set',
      description: 'Complete the algebra problem set',
      subject: 'Mathematics',
      teacherName: 'Mr. Brown',
      dueDate: DateTime.now().subtract(const Duration(days: 5)),
      status: 'submitted',
      attachmentUrl: null,
      marks: 18,
      grade: 'A',
      feedback: 'Well done',
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
    ),
    Assignment(
      id: '4',
      title: 'Creative Writing Short Story',
      description: 'Write a creative short story',
      subject: 'English',
      teacherName: 'Ms. Clark',
      dueDate: DateTime.now().add(const Duration(days: 10)),
      status: 'pending',
      attachmentUrl: null,
      marks: null,
      grade: null,
      feedback: null,
      createdAt: DateTime.now(),
    ),
  ];

  List<Assignment> get _filteredAssignments {
    switch (_selectedFilter) {
      case 'pending':
        return _assignments.where((a) => a.status == 'pending').toList();
      case 'submitted':
        return _assignments.where((a) => a.status == 'submitted').toList();
      case 'overdue':
        return _assignments.where((a) => a.status == 'overdue').toList();
      default:
        return _assignments;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Assignments'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: ThemeConstants.primaryDark,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: Column(
        children: [
          _buildFilterBar(),
          Expanded(
            child: _filteredAssignments.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: ThemeConstants.lg,
                vertical: ThemeConstants.md,
              ),
              itemCount: _filteredAssignments.length,
              itemBuilder: (context, index) {
                return _buildAssignmentCard(
                    _filteredAssignments[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(ThemeConstants.md),
      child: Row(
        children: [
          _buildFilterChip('all', 'All'),
          _buildFilterChip('pending', 'Pending'),
          _buildFilterChip('submitted', 'Submitted'),
          _buildFilterChip('overdue', 'Overdue'),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String value, String label) {
    final isSelected = _selectedFilter == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = value),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? ThemeConstants.primaryBlue
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: ThemeConstants.primaryBlue,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : ThemeConstants.primaryBlue,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildAssignmentCard(Assignment assignment, int index) {
    final daysUntilDue =
        assignment.dueDate.difference(DateTime.now()).inDays;

    return Container(
      margin: const EdgeInsets.only(bottom: ThemeConstants.md),
      padding: const EdgeInsets.all(ThemeConstants.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            assignment.title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            assignment.subject,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
          Text(
            assignment.status == 'overdue'
                ? 'Overdue: ${DateFormat('MMM dd').format(assignment.dueDate)}'
                : assignment.status == 'submitted'
                ? 'Submitted'
                : 'Due in $daysUntilDue days',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 500.ms, delay: (50 * index).ms)
        .slideY(begin: 0.2);
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text('No assignments available'),
    );
  }
}
