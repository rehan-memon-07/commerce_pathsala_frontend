// ============================================================================
// USER MODEL
// ============================================================================
// Represents student / teacher / admin user

class AppUser {
  final String id;
  final String name;
  final String email;
  final String role; // 'student', 'teacher', 'admin'

  // Optional fields based on role
  final String? grade;    // for students
  final String? subject;  // for teachers

  final String? profileImage;
  final String? className;
  final DateTime createdAt;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.grade,
    this.subject,
    this.profileImage,
    this.className,
    required this.createdAt,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? 'student',
      grade: json['grade'],
      subject: json['subject'],
      profileImage: json['profileImage'],
      className: json['className'],
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'grade': grade,
      'subject': subject,
      'profileImage': profileImage,
      'className': className,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Convenience getters
  bool get isStudent => role == 'student';
  bool get isTeacher => role == 'teacher';
  bool get isAdmin => role == 'admin';
}
