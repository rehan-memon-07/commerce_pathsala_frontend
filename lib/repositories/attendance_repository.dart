// ============================================================================
// ATTENDANCE REPOSITORY
// ============================================================================
// Handles attendance-related API calls for both marking and viewing

import 'package:commerce_paathshala_app/models/attendance_model.dart';
import 'package:commerce_paathshala_app/repositories/mock_data.dart';

abstract class AttendanceRepositoryBase {
  Future<AttendanceStats> getStudentAttendance(String studentId);
  Future<List<Attendance>> getClassAttendance(String classId, DateTime date);
  Future<bool> markAttendance(List<Attendance> attendanceList);
  Future<List<Attendance>> getAttendanceHistory(String studentId);
}

class AttendanceRepository implements AttendanceRepositoryBase {
  // TODO: Configure HTTP client endpoint
  // static const String _baseUrl = 'https://your-api.com/api';

  @override
  Future<AttendanceStats> getStudentAttendance(String studentId) async {
    try {
      // TODO: Send GET request to backend: /api/students/$studentId/attendance
      // Expected response: AttendanceStats JSON
      
      await Future.delayed(const Duration(seconds: 1));
      return MockData.mockAttendanceStats;
    } catch (e) {
      print('Error fetching attendance: $e');
      return AttendanceStats(
        overallPercentage: 0.0,
        totalClasses: 0,
        classesAttended: 0,
        subjectWisePercentage: {},
      );
    }
  }

  @override
  Future<List<Attendance>> getClassAttendance(String classId, DateTime date) async {
    try {
      // TODO: Send GET request to backend: /api/classes/$classId/attendance?date=$date
      // Returns list of attendance records for the class on that date
      
      await Future.delayed(const Duration(seconds: 1));
      return MockData.mockAttendanceRecords;
    } catch (e) {
      print('Error fetching class attendance: $e');
      return [];
    }
  }

  @override
  Future<bool> markAttendance(List<Attendance> attendanceList) async {
    try {
      // TODO: Send POST request to backend: /api/attendance/mark-bulk
      // Payload: { 'records': attendanceList.map((a) => a.toJson()).toList() }
      
      await Future.delayed(const Duration(seconds: 2));
      return true;
    } catch (e) {
      print('Error marking attendance: $e');
      return false;
    }
  }

  @override
  Future<List<Attendance>> getAttendanceHistory(String studentId) async {
    try {
      // TODO: Send GET request to backend: /api/students/$studentId/attendance-history
      // Returns paginated list of attendance records
      
      await Future.delayed(const Duration(seconds: 1));
      return MockData.mockAttendanceRecords;
    } catch (e) {
      print('Error fetching attendance history: $e');
      return [];
    }
  }
}
