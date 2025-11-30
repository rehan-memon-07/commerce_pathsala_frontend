// ============================================================================
// TEACHER PROVIDER - STATE MANAGEMENT
// ============================================================================
// Manages teacher-specific data: class management, marking, assignments
// Provider Pattern: Notifies UI when data changes

import 'package:flutter/material.dart';
import 'package:commerce_paathshala_app/models/assignment_model.dart';
import 'package:commerce_paathshala_app/models/attendance_model.dart';
import 'package:commerce_paathshala_app/repositories/assignment_repository.dart';
import 'package:commerce_paathshala_app/repositories/attendance_repository.dart';

class TeacherProvider extends ChangeNotifier {
  final AssignmentRepository _assignmentRepository = AssignmentRepository();
  final AttendanceRepository _attendanceRepository = AttendanceRepository();

  // State variables
  List<Assignment> _assignments = [];
  List<Attendance> _currentClassAttendance = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<Assignment> get assignments => _assignments;
  List<Attendance> get currentClassAttendance => _currentClassAttendance;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get pendingGrading => _assignments.where((a) => a.status == 'submitted').length;

  // ========== DATA FETCHING METHODS ==========

  /// Load teacher's assignments
  /// TODO: Replace 'teacher_001' with actual currentUser.id from AuthProvider
  Future<void> loadAssignments(String teacherId) async {
    _setLoading(true);
    try {
      _assignments = (await _assignmentRepository.getTeacherAssignments(teacherId))!;
      _setLoading(false);
    } catch (e) {
      _setError('Error loading assignments: $e');
      _setLoading(false);
    }
  }

  /// Load class attendance for marking
  /// TODO: Fetch attendance records from backend and mark as absent by default
  Future<void> loadClassAttendance(String classId, DateTime date) async {
    _setLoading(true);
    try {
      _currentClassAttendance = await _attendanceRepository.getClassAttendance(
        classId,
        date,
      );
      _setLoading(false);
    } catch (e) {
      _setError('Error loading attendance: $e');
      _setLoading(false);
    }
  }

  /// Create a new assignment
  /// TODO: Validate form data on backend
  /// TODO: Handle file attachments upload to cloud storage
  Future<bool> createAssignment(Assignment assignment) async {
    try {
      final success = await _assignmentRepository.createAssignment(assignment);
      if (success) {
        _assignments.add(assignment);
        notifyListeners();
      }
      return success;
    } catch (e) {
      _setError('Error creating assignment: $e');
      return false;
    }
  }

  /// Mark attendance for entire class
  /// TODO: Send attendance data with class date and subject
  /// TODO: Update backend and refresh local data
  Future<bool> markAttendance(List<Attendance> attendanceList) async {
    try {
      final success = await _attendanceRepository.markAttendance(attendanceList);
      if (success) {
        _currentClassAttendance = attendanceList;
        notifyListeners();
      }
      return success;
    } catch (e) {
      _setError('Error marking attendance: $e');
      return false;
    }
  }

  /// Grade a submitted assignment
  /// TODO: Validate marks and feedback on frontend
  /// TODO: Send to backend with timestamp and teacher ID
  Future<bool> gradeAssignment(String assignmentId, int marks, String feedback) async {
    try {
      final success = await _assignmentRepository.gradeAssignment(
        assignmentId,
        marks,
        feedback,
      );
      
      if (success) {
        // Update assignment status in local list
        final index = _assignments.indexWhere((a) => a.id == assignmentId);
        if (index != -1) {
          _assignments[index] = Assignment(
            id: _assignments[index].id,
            title: _assignments[index].title,
            description: _assignments[index].description,
            subject: _assignments[index].subject,
            teacherName: _assignments[index].teacherName,
            dueDate: _assignments[index].dueDate,
            status: 'graded',
            marks: marks,
            feedback: feedback,
            createdAt: _assignments[index].createdAt,
          );
          notifyListeners();
        }
      }
      return success;
    } catch (e) {
      _setError('Error grading assignment: $e');
      return false;
    }
  }

  /// Toggle attendance status for a student
  /// Used when marking attendance - update local state
  void toggleStudentAttendance(String attendanceId) {
    final index = _currentClassAttendance.indexWhere((a) => a.id == attendanceId);
    if (index != -1) {
      final attendance = _currentClassAttendance[index];
      _currentClassAttendance[index] = Attendance(
        id: attendance.id,
        studentId: attendance.studentId,
        studentName: attendance.studentName,
        subject: attendance.subject,
        className: attendance.className,
        date: attendance.date,
        isPresent: !attendance.isPresent,
        remarks: attendance.remarks,
      );
      notifyListeners();
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
}
