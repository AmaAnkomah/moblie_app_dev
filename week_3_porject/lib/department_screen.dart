import 'package:flutter/material.dart';

class DepartmentsScreen extends StatelessWidget {
  const DepartmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Departments'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.computer),
            title: const Text('Computer Science'),
            subtitle: const Text('Department of Computing Sciences'),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/department/detail',
                arguments: {'name': 'Computer Science'},
              );
              // We'll add navigation later
            },
          ),
          ListTile(
            leading: const Icon(Icons.engineering),
            title: const Text('Engineering'),
            subtitle: const Text('School of Engineering'),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/department/detail',
                arguments: {'name': 'Engineering'},
              );
              // We'll add navigation later
            },
          ),
          ListTile(
            leading: const Icon(Icons.business),
            title: const Text('Business Administration'),
            subtitle: const Text('School of Business'),
            onTap: () {
              // We'll add navigation later
              Navigator.pushNamed(
                context,
                '/department/detail',
                arguments: {'name': 'Business'},
              );
            },
          ),
        ],
      ),
    );
  }
}