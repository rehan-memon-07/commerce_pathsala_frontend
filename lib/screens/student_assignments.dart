import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../constants/theme_constants.dart';
import '../models/user_model.dart';

class StudentAssignmentsScreen extends StatefulWidget {
  const StudentAssignmentsScreen({Key? key}) : super(key: key);

  @override
  State<StudentAssignmentsScreen> createState() => _StudentAssignmentsScreenState();
}

class _StudentAssignmentsScreenState extends State<StudentAssignmentsScreen> {
  String _selectedFilter = 'all';

  final List<Assignment> _assignments = [
    Assignment(
      id: '1',
      title: 'History Essay: The Roman Empire',
      subject: 'History',
      description: 'Write a comprehensive essay about the Roman Empire',
      dueDate: DateTime.now().add(const Duration(days: -3)),
      status: 'overdue',
      submissionDate: null,
    ),
    Assignment(
      id: '2',
      title: 'Chapter 5 Reading Quiz',
      subject: 'Biology',
      description: 'Complete the reading quiz on Chapter 5',
      dueDate: DateTime.now().add(const Duration(days: 3)),
      status: 'pending',
      submissionDate: null,
    ),
    Assignment(
      id: '3',
      title: 'Algebra Problem Set',
      subject: 'Mathematics',
      description: 'Complete the algebra problem set',
      dueDate: DateTime.now().subtract(const Duration(days: 5)),
      status: 'submitted',
      submissionDate: DateTime.now()
          .subtract(const Duration(days: 1))
          .toIso8601String(),
    ),
    Assignment(
      id: '4',
      title: 'Creative Writing Short Story',
      subject: 'English',
      description: 'Write a creative short story',
      dueDate: DateTime.now().add(const Duration(days: 10)),
      status: 'pending',
      submissionDate: null,
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: ThemeConstants.lg),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(Icons.search_rounded),
            ),
          ),
        ],
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
                      return _buildAssignmentCard(_filteredAssignments[index], index);
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
      padding: const EdgeInsets.symmetric(
        horizontal: ThemeConstants.lg,
        vertical: ThemeConstants.md,
      ),
      child: Row(
        children: [
          _buildFilterChip('all', 'All'),
          const SizedBox(width: ThemeConstants.sm),
          _buildFilterChip('pending', 'Pending'),
          const SizedBox(width: ThemeConstants.sm),
          _buildFilterChip('submitted', 'Submitted'),
          const SizedBox(width: ThemeConstants.sm),
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
        padding: const EdgeInsets.symmetric(
          horizontal: ThemeConstants.lg,
          vertical: ThemeConstants.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? ThemeConstants.primaryBlue : Colors.white,
          border: Border.all(
            color: isSelected ? ThemeConstants.primaryBlue : ThemeConstants.borderColor,
          ),
          borderRadius: BorderRadius.circular(ThemeConstants.radiusLg),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : ThemeConstants.textMedium,
          ),
        ),
      ),
    );
  }

  Widget _buildAssignmentCard(Assignment assignment, int index) {
    final subjectColor = getSubjectColor(assignment.subject);
    final statusIcon = _getStatusIcon(assignment.status);
    final statusColor = _getStatusColor(assignment.status);
    final daysUntilDue = assignment.dueDate.difference(DateTime.now()).inDays;

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
        border: assignment.status == 'overdue'
            ? Border.all(color: ThemeConstants.errorColor.withOpacity(0.2))
            : null,
      ),
      padding: const EdgeInsets.all(ThemeConstants.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: subjectColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.assignment_rounded,
                  color: subjectColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: ThemeConstants.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      assignment.title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: subjectColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        assignment.subject,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: subjectColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  statusIcon,
                  color: statusColor,
                  size: 22,
                ),
              ),
            ],
          ),
          const SizedBox(height: ThemeConstants.md),
          Row(
            children: [
              Icon(
                Icons.calendar_today_rounded,
                size: 16,
                color: ThemeConstants.textLight,
              ),
              const SizedBox(width: 6),
              Text(
                assignment.status == 'overdue'
                    ? 'Overdue: ${DateFormat('MMM dd').format(assignment.dueDate)}'
                    : assignment.status == 'submitted'
                        ? 'Submitted: ${DateFormat('MMM dd').format(assignment.submissionDate! as DateTime)}'
                        : 'Due: ${daysUntilDue == 0 ? 'Today' : 'in $daysUntilDue days'}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: assignment.status == 'overdue'
                          ? ThemeConstants.errorColor
                          : ThemeConstants.textMedium,
                    ),
              ),
              const Spacer(),
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
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: (50 * index).ms)
        .slideY(begin: 0.2);
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: ThemeConstants.successColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              size: 50,
              color: ThemeConstants.successColor,
            ),
          ),
          const SizedBox(height: ThemeConstants.lg),
          Text(
            "You're all caught up!",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'You have no pending assignments at the moment. Great job!',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'submitted':
        return Icons.check_circle_rounded;
      case 'overdue':
        return Icons.error_rounded;
      default:
        return Icons.schedule_rounded;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'submitted':
        return ThemeConstants.successColor;
      case 'overdue':
        return ThemeConstants.errorColor;
      default:
        return ThemeConstants.warningColor;
    }
  }
}
