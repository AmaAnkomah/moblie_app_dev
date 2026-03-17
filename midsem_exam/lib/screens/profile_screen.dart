import 'package:flutter/material.dart';
import '../models/student.dart';
import 'task_list_screen.dart';

/// Screen displaying the student's profile information.
/// It also provides a button to navigate to the tasks list.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  final Student student = const Student(
    name: "John Doe",
    studentId: "12345678",
    programme: "Computer Science",
    level: 300,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                child: Text(
                  student.name[0],
                  style: const TextStyle(fontSize: 40),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text("Name: ${student.name}", style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 8),
                      Text("ID: ${student.studentId}", style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 8),
                      Text("Programme: ${student.programme}", style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 8),
                      Text("Level: ${student.level}", style: const TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Edit profile action (not required)
                },
                child: const Text("Edit Profile"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TaskListScreen()),
                  );
                },
                child: const Text("View Tasks"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
