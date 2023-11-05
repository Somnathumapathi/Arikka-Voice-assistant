import 'package:arikka/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Arikka - Voice Assistant Ai',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Color.fromARGB(255, 48, 3, 106),
          ),
          scaffoldBackgroundColor: const Color.fromARGB(255, 34, 1, 62),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Color.fromARGB(255, 61, 5, 151))),
      home: const HomeScreen(),
    );
  }
}
