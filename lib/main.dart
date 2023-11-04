import 'package:arikka/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
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
            color: Color.fromARGB(255, 58, 3, 106),
          ),
          scaffoldBackgroundColor: const Color.fromARGB(255, 38, 3, 71),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Color.fromARGB(255, 83, 5, 151))),
      home: const HomeScreen(),
    );
  }
}
