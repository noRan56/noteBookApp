import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/OTP/OTP-Pages.dart';
import 'package:task/OTP/sign_up.dart';
import 'package:task/provider/notes/notes_provider.dart';
import 'package:task/screens/home/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NotesProvider())],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MY Daily',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
            useMaterial3: true,
          ),
          home: OnboardingScreen()),
      // home: const HomeScreen()),
    );
  }
}
