import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

/// A stateful screen that displays a list of tasks.
/// Allows adding new tasks via a FloatingActionButton
/// and toggling task completion status using Checkboxes.
class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  static const String tasksKey = 'saved_tasks';
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksJson = prefs.getString(tasksKey);

    if (tasksJson != null) {
      // Decode the JSON list and map each map to a Task object
      final List<dynamic> decodedList = json.decode(tasksJson);
      setState(() {
        _tasks = decodedList.map((item) => Task.fromJson(item)).toList();
      });
    } else {
      // Load hardcoded list if no saved data exists
      setState(() {
        _tasks = [
          Task(title: "Assignment 1", courseCode: "CS 301", dueDate: DateTime.now()),
          Task(title: "Project Proposal", courseCode: "CS 302", dueDate: DateTime.now().add(const Duration(days: 2))),
          Task(title: "Midterm Exam", courseCode: "CS 303", dueDate: DateTime.now().add(const Duration(days: 7))),
        ];
      });
      _saveTasks();
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    // Encode the list of tasks as a JSON string
    final String encodedList = json.encode(_tasks.map((task) => task.toJson()).toList());
    await prefs.setString(tasksKey, encodedList);
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  void _showAddTaskDialog() {
    final titleController = TextEditingController();
    final courseCodeController = TextEditingController();
    DateTime? selectedDate;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text("Add Task"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: "Task Title"),
                  ),
                  TextField(
                    controller: courseCodeController,
                    decoration: const InputDecoration(labelText: "Course Code"),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(selectedDate == null 
                          ? "No Date Chosen" 
                          : _formatDate(selectedDate!)),
                      const Spacer(),
                      TextButton(
                        onPressed: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            setStateDialog(() {
                              selectedDate = pickedDate;
                            });
                          }
                        },
                        child: const Text("Choose Date"),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty &&
                        courseCodeController.text.isNotEmpty &&
                        selectedDate != null) {
                      setState(() {
                        _tasks.add(Task(
                          title: titleController.text,
                          courseCode: courseCodeController.text,
                          dueDate: selectedDate!,
                        ));
                      });
                      _saveTasks();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Save"),
                ),
              ],
            );
          }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
      ),
      body: _tasks.isEmpty
          ? const Center(child: Text("No tasks added yet."))
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return ListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.isComplete ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  subtitle: Text("${task.courseCode} - ${_formatDate(task.dueDate)}"),
                  trailing: Checkbox(
                    value: task.isComplete,
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          task.isComplete = value;
                        });
                        _saveTasks();
                      }
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

