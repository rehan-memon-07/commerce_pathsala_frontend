// ============================================================================
// ASSIGNMENT MODEL
// ============================================================================
// Represents assignment data for both display and submission

class Assignment {
  final String id;
  final String title;
  final String description;
  final String subject;
  final String teacherName;
  final DateTime dueDate;
  final String status; // 'pending', 'submitted', 'overdue', 'graded'
  final String? attachmentUrl;
  final int? marks;
  final String? grade;
  final String? feedback;
  final DateTime createdAt;

  Assignment({
    required this.id,
    required this.title,
    required this.description,
    required this.subject,
    required this.teacherName,
    required this.dueDate,
    required this.status,
    this.attachmentUrl,
    this.marks,
    this.grade,
    this.feedback,
    required this.createdAt,
  });

  // Convert JSON to Assignment object - Used when fetching from backend API
  // TODO: Ensure field names match backend API response
  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      subject: json['subject'] ?? '',
      teacherName: json['teacherName'] ?? '',
      dueDate: DateTime.parse(json['dueDate'] ?? DateTime.now().toString()),
      status: json['status'] ?? 'pending',
      attachmentUrl: json['attachmentUrl'],
      marks: json['marks'],
      grade: json['grade'],
      feedback: json['feedback'],
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'subject': subject,
      'teacherName': teacherName,
      'dueDate': dueDate.toIso8601String(),
      'status': status,
      'attachmentUrl': attachmentUrl,
      'marks': marks,
      'grade': grade,
      'feedback': feedback,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Compute days until due date
  int get daysUntilDue {
    return dueDate.difference(DateTime.now()).inDays;
  }

  // Check if assignment is overdue
  bool get isOverdue {
    return DateTime.now().isAfter(dueDate) && status != 'submitted';
  }
}
