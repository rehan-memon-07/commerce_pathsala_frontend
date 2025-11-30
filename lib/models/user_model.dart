class User {
  final String id;
  final String name;
  final String email;
  final String role; // 'student', 'teacher', 'admin'
  final String? profileImage;
  final String? className;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.profileImage,
    this.className, required String grade, required DateTime createdAt, required String subject,
  });
}

class Assignment {
  final String id;
  final String title;
  final String subject;
  final String description;
  final DateTime dueDate;
  final String status; // 'pending', 'submitted', 'overdue'
  final String? submissionDate;

  Assignment({
    required this.id,
    required this.title,
    required this.subject,
    required this.description,
    required this.dueDate,
    required this.status,
    this.submissionDate,
  });
}

class AttendanceRecord {
  final String studentId;
  final String studentName;
  final String rollNo;
  final bool isPresent;

  AttendanceRecord({
    required this.studentId,
    required this.studentName,
    required this.rollNo,
    required this.isPresent,
  });
}
