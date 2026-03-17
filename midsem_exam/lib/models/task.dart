/// A model class representing a Task.
/// Holds details about academic tasks such as assignments or exams.
class Task {
  // The title or name of the task
  final String title;
  // The course code associated with the task
  final String courseCode;
  // The date by which the task is due
  final DateTime dueDate;
  // A boolean flag indicating if the task has been completed
  bool isComplete;

  /// Constructor requires title, courseCode, and dueDate.
  /// isComplete defaults to false if not provided.
  Task({
    required this.title,
    required this.courseCode,
    required this.dueDate,
    this.isComplete = false,
  });
}
