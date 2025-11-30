// ============================================================================
// MOCK DATA REPOSITORY
// ============================================================================
// Contains hardcoded data for development and testing purposes
// This will be replaced with actual API calls to the backend
// Useful for testing UI without depending on API availability

import 'package:commerce_paathshala_app/models/user_model.dart' hide Assignment;
import 'package:commerce_paathshala_app/models/assignment_model.dart';
import 'package:commerce_paathshala_app/models/attendance_model.dart';

class MockData {
  // ========== MOCK USERS ==========
  static final User mockStudent = User(
    id: 'student_001',
    name: 'Brooklyn Simmons',
    email: 'brooklyn.simmons@school.com',
    profileImage: 'https://via.placeholder.com/150?text=BS',
    role: 'student',
    grade: 'Grade 10',
    createdAt: DateTime.now(), subject: '',
  );

  static final User mockTeacher = User(
    id: 'teacher_001',
    name: 'Mrs. Davison',
    email: 'mrs.davison@school.com',
    profileImage: 'https://via.placeholder.com/150?text=MD',
    role: 'teacher',
    subject: 'Mathematics',
    createdAt: DateTime.now(), grade: '',
  );

  // ========== MOCK ASSIGNMENTS ==========
  static final List<Assignment> mockStudentAssignments = [
    Assignment(
      id: 'assign_001',
      title: 'Algebra Homework 3',
      description: 'Complete exercises 1-20 from Chapter 5',
      subject: 'Mathematics',
      teacherName: 'Mr. Johnson',
      dueDate: DateTime.now().add(const Duration(days: 3)),
      status: 'pending',
      attachmentUrl: null,
      createdAt: DateTime.now(),
    ),
    Assignment(
      id: 'assign_002',
      title: 'Lab Report: Chemical Reactions',
      description: 'Document your findings from the lab experiment',
      subject: 'Science',
      teacherName: 'Dr. Smith',
      dueDate: DateTime.now().add(const Duration(days: 7)),
      status: 'pending',
      attachmentUrl: null,
      createdAt: DateTime.now(),
    ),
    Assignment(
      id: 'assign_003',
      title: 'The Great Gatsby Essay',
      description: 'Write a 2-page essay on character development',
      subject: 'English',
      teacherName: 'Ms. Williams',
      dueDate: DateTime.now().subtract(const Duration(days: 2)),
      status: 'overdue',
      attachmentUrl: null,
      createdAt: DateTime.now(),
    ),
    Assignment(
      id: 'assign_004',
      title: 'History Project: Civil War',
      description: 'Create a presentation on the American Civil War',
      subject: 'History',
      teacherName: 'Mr. Brown',
      dueDate: DateTime.now().subtract(const Duration(days: 5)),
      status: 'submitted',
      marks: 85,
      grade: 'A',
      createdAt: DateTime.now(),
    ),
  ];

  static final List<Assignment> mockTeacherAssignments = [
    Assignment(
      id: 'assign_101',
      title: 'Chapter 5 Exercises',
      description: 'Algebra problem set from textbook',
      subject: 'Mathematics',
      teacherName: 'Mrs. Davison',
      dueDate: DateTime.now().add(const Duration(days: 5)),
      status: 'pending',
      createdAt: DateTime.now(),
    ),
    Assignment(
      id: 'assign_102',
      title: 'Quadratic Equations Test',
      description: 'In-class assessment on quadratic equations',
      subject: 'Mathematics',
      teacherName: 'Mrs. Davison',
      dueDate: DateTime.now().add(const Duration(days: 2)),
      status: 'pending',
      createdAt: DateTime.now(),
    ),
  ];

  // ========== MOCK ATTENDANCE ==========
  static final List<Attendance> mockAttendanceRecords = [
    Attendance(
      id: 'attend_001',
      studentId: 'student_001',
      studentName: 'Ananya Sharma',
      subject: 'Mathematics',
      className: 'Class 10 - A',
      date: DateTime.now().subtract(const Duration(days: 1)),
      isPresent: true,
    ),
    Attendance(
      id: 'attend_002',
      studentId: 'student_002',
      studentName: 'Rohan Verma',
      subject: 'Mathematics',
      className: 'Class 10 - A',
      date: DateTime.now().subtract(const Duration(days: 1)),
      isPresent: false,
    ),
    Attendance(
      id: 'attend_003',
      studentId: 'student_003',
      studentName: 'Priya Singh',
      subject: 'Mathematics',
      className: 'Class 10 - A',
      date: DateTime.now().subtract(const Duration(days: 1)),
      isPresent: true,
    ),
  ];

  static final AttendanceStats mockAttendanceStats = AttendanceStats(
    overallPercentage: 85.0,
    totalClasses: 200,
    classesAttended: 170,
    subjectWisePercentage: {
      'Mathematics': 92.0,
      'Science': 88.0,
      'English': 90.0,
      'History': 78.0,
      'Biology': 85.0,
    },
  );

  // ========== MOCK DASHBOARD DATA ==========
  static final Map<String, dynamic> mockStudentDashboardData = {
    'studentName': 'Brooklyn Simmons',
    'grade': 'Grade 10',
    'attendance': 92.0,
    'newAssignments': 3,
    'pendingSubmissions': 2,
    'recentAssignments': mockStudentAssignments.take(4).toList(),
  };

  static final Map<String, dynamic> mockTeacherDashboardData = {
    'teacherName': 'Mrs. Davison',
    'subject': 'Mathematics',
    'totalClasses': 5,
    'totalStudents': 45,
    'averageAttendance': 82.5,
    'pendingAssignments': 12,
    'pendingGrading': 8,
  };
}
