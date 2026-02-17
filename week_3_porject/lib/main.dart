import 'package:flutter/material.dart';
import 'department_detail_screen.dart';
import 'faculty_screen.dart';
import 'department_screen.dart';
import 'faculty_screen.dart';
import 'department_detail_screen.dart';
void main() {
  runApp(const CampusDirectoryApp());
}

class CampusDirectoryApp extends StatelessWidget {
  const CampusDirectoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VVU Campus Directory',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/faculty': (context) => const FacultyScreen(),
        '/departments': (context) => const DepartmentsScreen(),
        '/department/detail': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map;
          return DepartmentDetailScreen(departmentName: args['name']);
        },
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('VVU Campus Directory')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to VVU Directory',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // We'll add navigation here
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DepartmentsScreen(),
                  ),
                );
              },
              child: const Text('View Departments'),
            ),
          ],
        ),
      ),
    );
  }
}