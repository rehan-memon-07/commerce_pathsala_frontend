// ============================================================================
// STUDENT ASSIGNMENTS SCREEN
// ============================================================================
// Shows list of all assignments with status badges
// TODO: Add filtering by status (pending, submitted, overdue)
// TODO: Add search functionality

import 'package:flutter/material.dart';
import "package:commerce_paathshala_app/provider/provider.dart";
import 'package:commerce_paathshala_app/config/theme_config.dart';
import 'package:commerce_paathshala_app/providers/student_provider.dart';
import 'package:provider/provider.dart';

class StudentAssignmentsScreen extends StatefulWidget {
  const StudentAssignmentsScreen({Key? key}) : super(key: key);

  @override
  State<StudentAssignmentsScreen> createState() =>
      _StudentAssignmentsScreenState();
}

class _StudentAssignmentsScreenState extends State<StudentAssignmentsScreen> {
  String _selectedFilter = 'all';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Assignments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search functionality
            },
          ),
        ],
      ),
      body: Consumer<StudentProvider>(
        builder: (context, studentProvider, _) {
          final assignments = _filterAssignments(
            studentProvider.assignments,
            _selectedFilter,
          );

          return Column(
            children: [
              // Filter chips
              Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('All', 'all'),
                      const SizedBox(width: 8),
                      _buildFilterChip('Pending', 'pending'),
                      const SizedBox(width: 8),
                      _buildFilterChip('Submitted', 'submitted'),
                      const SizedBox(width: 8),
                      _buildFilterChip('Overdue', 'overdue'),
                    ],
                  ),
                ),
              ),
              // Assignment list
              Expanded(
                child: assignments.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '✓',
                              style: TextStyle(fontSize: 64),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'All Caught Up!',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'No assignments in this category',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: assignments.length,
                        itemBuilder: (context, index) {
                          final assignment = assignments[index];
                          return _buildAssignmentCard(context, assignment);
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    return FilterChip(
      label: Text(label),
      selected: _selectedFilter == value,
      onSelected: (selected) {
        setState(() => _selectedFilter = value);
      },
    );
  }

  Widget _buildAssignmentCard(BuildContext context, dynamic assignment) {
    final statusColor = _getStatusColor(assignment.status);
    final statusIcon = _getStatusIcon(assignment.status);

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
                    child: Text(statusIcon, style: TextStyle(fontSize: 24)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              assignment.title,
                              style: Theme.of(context).textTheme.bodyLarge,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              assignment.status,
                              style: TextStyle(
                                fontSize: 12,
                                color: statusColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: ThemeConfig.getSubjectColor(assignment.subject)
                                  .withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              assignment.subject,
                              style: TextStyle(
                                fontSize: 12,
                                color: ThemeConfig.getSubjectColor(
                                  assignment.subject,
                                ),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
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
                    // TODO: Navigate to assignment details screen
                  },
                  child: const Text('View Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return ThemeConfig.warningOrange;
      case 'submitted':
        return ThemeConfig.successGreen;
      case 'overdue':
        return ThemeConfig.errorRed;
      case 'graded':
        return ThemeConfig.primaryBlue;
      default:
        return ThemeConfig.darkGrey;
    }
  }

  String _getStatusIcon(String status) {
    switch (status) {
      case 'pending':
        return '⏳';
      case 'submitted':
        return '✓';
      case 'overdue':
        return '⚠';
      case 'graded':
        return '📊';
      default:
        return '📋';
    }
  }

  List<dynamic> _filterAssignments(List<dynamic> assignments, String filter) {
    if (filter == 'all') {
      return assignments;
    } else if (filter == 'overdue') {
      return assignments.where((a) => a.isOverdue).toList();
    } else {
      return assignments.where((a) => a.status == filter).toList();
    }
  }
}
