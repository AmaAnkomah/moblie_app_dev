import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase as required by the exam.
  // Using dummy initialization since we don't have google-services.json
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'dummy_api_key',
      appId: 'dummy_app_id',
      messagingSenderId: 'dummy_sender_id',
      projectId: 'dummy_project_id',
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Midsem Exam App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Set the home screen to LoginScreen as required by the login flow
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

