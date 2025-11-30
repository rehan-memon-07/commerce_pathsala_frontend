// ============================================================================
// ATTENDANCE MODEL
// ============================================================================
// Represents attendance records and statistics

class Attendance {
  final String id;
  final String studentId;
  final String studentName;
  final String subject;
  final String className;
  final DateTime date;
  final bool isPresent;
  final String? remarks;

  Attendance({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.subject,
    required this.className,
    required this.date,
    required this.isPresent,
    this.remarks,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'] ?? '',
      studentId: json['studentId'] ?? '',
      studentName: json['studentName'] ?? '',
      subject: json['subject'] ?? '',
      className: json['className'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toString()),
      isPresent: json['isPresent'] ?? false,
      remarks: json['remarks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'studentName': studentName,
      'subject': subject,
      'className': className,
      'date': date.toIso8601String(),
      'isPresent': isPresent,
      'remarks': remarks,
    };
  }
}

// Attendance Statistics Model
class AttendanceStats {
  final double overallPercentage;
  final int totalClasses;
  final int classesAttended;
  final Map<String, double> subjectWisePercentage;

  AttendanceStats({
    required this.overallPercentage,
    required this.totalClasses,
    required this.classesAttended,
    required this.subjectWisePercentage,
  });

  factory AttendanceStats.fromJson(Map<String, dynamic> json) {
    return AttendanceStats(
      overallPercentage: (json['overallPercentage'] as num?)?.toDouble() ?? 0.0,
      totalClasses: json['totalClasses'] ?? 0,
      classesAttended: json['classesAttended'] ?? 0,
      subjectWisePercentage: Map<String, double>.from(
        (json['subjectWisePercentage'] as Map?)?.map(
          (key, value) => MapEntry(key, (value as num?)?.toDouble() ?? 0.0),
        ) ?? {},
      ),
    );
  }
}
