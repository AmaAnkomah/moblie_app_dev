/// A model class representing a Student.
/// Contains the student's personal and academic details.
class Student {
  // The full name of the student
  final String name;
  // The unique identifier for the student
  final String studentId;
  // The academic programme the student is enrolled in
  final String programme;
  // The current academic level of the student (e.g., 300)
  final int level;

  /// Constructor requires all fields to be initialized
  /// when creating a new Student instance.
  const Student({
    required this.name,
    required this.studentId,
    required this.programme,
    required this.level,
  });
}
