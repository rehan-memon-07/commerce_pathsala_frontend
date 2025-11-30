// ============================================================================
// STUDENT PROVIDER - STATE MANAGEMENT
// ============================================================================
// Manages student-specific data: assignments, attendance, dashboard info
// Provider Pattern: Notifies UI when data changes

import 'package:flutter/material.dart';
import 'package:commerce_paathshala_app/models/assignment_model.dart';
import 'package:commerce_paathshala_app/models/attendance_model.dart';
import 'package:commerce_paathshala_app/repositories/assignment_repository.dart';
import 'package:commerce_paathshala_app/repositories/attendance_repository.dart';

class StudentProvider extends ChangeNotifier {
  final AssignmentRepository _assignmentRepository = AssignmentRepository();
  final AttendanceRepository _attendanceRepository = AttendanceRepository();

  // State variables
  List<Assignment> _assignments = [];
  AttendanceStats? _attendanceStats;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<Assignment> get assignments => _assignments;
  AttendanceStats? get attendanceStats => _attendanceStats;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get pendingAssignments => _assignments.where((a) => a.status == 'pending').length;
  int get overdueAssignments => _assignments.where((a) => a.isOverdue).length;

  // ========== DATA FETCHING METHODS ==========

  /// Load all student assignments
  /// TODO: Replace 'student_001' with actual currentUser.id from AuthProvider
  Future<void> loadAssignments(String studentId) async {
    _setLoading(true);
    try {
      _assignments = (await _assignmentRepository.getStudentAssignments(studentId))!;
      _setLoading(false);
    } catch (e) {
      _setError('Error loading assignments: $e');
      _setLoading(false);
    }
  }

  /// Load student attendance statistics
  /// TODO: Replace 'student_001' with actual currentUser.id
  Future<void> loadAttendance(String studentId) async {
    _setLoading(true);
    try {
      _attendanceStats = await _attendanceRepository.getStudentAttendance(studentId);
      _setLoading(false);
    } catch (e) {
      _setError('Error loading attendance: $e');
      _setLoading(false);
    }
  }

  /// Submit an assignment
  /// TODO: Handle file upload to backend storage (Firebase, AWS S3, etc.)
  /// TODO: Send submission with file URL to backend
  Future<bool> submitAssignment(String assignmentId, String submissionUrl) async {
    try {
      final success = await _assignmentRepository.submitAssignment(
        assignmentId,
        submissionUrl,
      );
      
      if (success) {
        // Update local assignment status
        final index = _assignments.indexWhere((a) => a.id == assignmentId);
        if (index != -1) {
          _assignments[index] = Assignment(
            id: _assignments[index].id,
            title: _assignments[index].title,
            description: _assignments[index].description,
            subject: _assignments[index].subject,
            teacherName: _assignments[index].teacherName,
            dueDate: _assignments[index].dueDate,
            status: 'submitted',
            attachmentUrl: submissionUrl,
            createdAt: _assignments[index].createdAt,
          );
          notifyListeners();
        }
      }
      return success;
    } catch (e) {
      _setError('Error submitting assignment: $e');
      return false;
    }
  }

  // ========== HELPER METHODS ==========

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  /// Filter assignments by status
  List<Assignment> getAssignmentsByStatus(String status) {
    return _assignments.where((a) => a.status == status).toList();
  }

  /// Filter assignments by subject
  List<Assignment> getAssignmentsBySubject(String subject) {
    return _assignments.where((a) => a.subject == subject).toList();
  }
}
