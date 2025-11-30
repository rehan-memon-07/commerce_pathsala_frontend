// ============================================================================
// ASSIGNMENT REPOSITORY
// ============================================================================
// Handles assignment-related API calls and data management
// Manages both student and teacher assignment operations

import 'package:commerce_paathshala_app/models/assignment_model.dart';
import 'package:commerce_paathshala_app/repositories/mock_data.dart';

abstract class AssignmentRepositoryBase {
  Future<List<Assignment>> getStudentAssignments(String studentId);
  Future<List<Assignment>> getTeacherAssignments(String teacherId);
  Future<Assignment?> getAssignmentById(String assignmentId);
  Future<bool> submitAssignment(String assignmentId, String submissionUrl);
  Future<bool> createAssignment(Assignment assignment);
  Future<bool> gradeAssignment(String assignmentId, int marks, String feedback);
}

class AssignmentRepository implements AssignmentRepositoryBase {
  // TODO: Configure HTTP client with base URL to your backend
  // static const String _baseUrl = 'https://your-api.com/api';

  @override
  Future<List<Assignment>> getStudentAssignments(String studentId) async {
    try {
      // TODO: Replace mock with actual GET request to
      // /api/students/$studentId/assignments
      // Example: GET $_baseUrl/students/$studentId/assignments
      // Include Authorization header if required.

      await Future.delayed(const Duration(seconds: 1));
      // Ensure non-nullable List<Assignment> returned
      return MockData.mockStudentAssignments;
    } catch (e, st) {
      // Log error (consider stronger logging in production)
      // ignore: avoid_print
      print('Error fetching student assignments: $e\n$st');
      return <Assignment>[];
    }
  }

  @override
  Future<List<Assignment>> getTeacherAssignments(String teacherId) async {
    try {
      // TODO: Replace mock with actual GET request to
      // /api/teachers/$teacherId/assignments

      await Future.delayed(const Duration(seconds: 1));
      return MockData.mockTeacherAssignments;
    } catch (e, st) {
      // ignore: avoid_print
      print('Error fetching teacher assignments: $e\n$st');
      return <Assignment>[];
    }
  }

  @override
  Future<Assignment?> getAssignmentById(String assignmentId) async {
    try {
      // TODO: Replace with GET request to /api/assignments/$assignmentId

      await Future.delayed(const Duration(milliseconds: 500));
      // safer lookup: return null if not found
      final list = MockData.mockStudentAssignments;
      final found = list.where((a) => a.id == assignmentId).toList();

      return found.isNotEmpty ? found.first : null;

    } catch (e, st) {
      // ignore: avoid_print
      print('Error fetching assignment: $e\n$st');
      return null;
    }
  }

  @override
  Future<bool> submitAssignment(String assignmentId, String submissionUrl) async {
    try {
      // TODO: Implement multipart file upload / POST to
      // /api/assignments/$assignmentId/submit
      // Payload example: { 'submissionUrl': submissionUrl }
      // Return true if backend responds OK.

      await Future.delayed(const Duration(seconds: 2));
      return true;
    } catch (e, st) {
      // ignore: avoid_print
      print('Error submitting assignment: $e\n$st');
      return false;
    }
  }

  @override
  Future<bool> createAssignment(Assignment assignment) async {
    try {
      // TODO: Replace mock with POST request to /api/assignments
      // Body: assignment.toJson()
      // Example using 'http' or 'dio':
      // final resp = await _httpClient.post('$_baseUrl/assignments', data: assignment.toJson());
      // return resp.statusCode == 201;

      await Future.delayed(const Duration(seconds: 1));
      return true;
    } catch (e, st) {
      // ignore: avoid_print
      print('Error creating assignment: $e\n$st');
      return false;
    }
  }

  @override
  Future<bool> gradeAssignment(
      String assignmentId, int marks, String feedback) async {
    try {
      // TODO: Replace with PUT/PATCH request to
      // /api/assignments/$assignmentId/grade
      // Body: { 'marks': marks, 'feedback': feedback }

      await Future.delayed(const Duration(seconds: 1));
      return true;
    } catch (e, st) {
      // ignore: avoid_print
      print('Error grading assignment: $e\n$st');
      return false;
    }
  }
}
