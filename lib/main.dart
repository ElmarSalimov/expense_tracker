import 'package:expense_tracker/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static _MyAppState? of(BuildContext context) {
    return context.findAncestorStateOfType<_MyAppState>();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void setThemeMode(bool isDarkMode) {
    if (isDarkMode == true) {
      setState(() {
        _themeMode = ThemeMode.dark;
      });
    }

    if (isDarkMode == false) {
      setState(() {
        _themeMode = ThemeMode.light;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[400],
          titleTextStyle: GoogleFonts.lato(fontSize: 18, color: Colors.black),
        ),
        colorScheme: ColorScheme.light(
          brightness: Brightness.light,
          primary: Colors.grey[300]!,
          onPrimary: Colors.black,
          secondary: Colors.grey[400]!,
          onSecondary: Colors.grey.shade700,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor:
                WidgetStateProperty.resolveWith((states) => Colors.black),
          ),
        ),
        textTheme: TextTheme(
          bodyLarge: GoogleFonts.lato(
            textStyle: const TextStyle(fontSize: 18, color: Colors.black),
          ),
          bodyMedium: GoogleFonts.lato(
            textStyle: const TextStyle(fontSize: 15, color: Colors.black),
          ),
          bodySmall: GoogleFonts.lato(
            textStyle: const TextStyle(fontSize: 12, color: Colors.black),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        snackBarTheme: const SnackBarThemeData(backgroundColor: Colors.black, actionTextColor: Colors.white),
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[800],
          titleTextStyle: GoogleFonts.lato(fontSize: 18, color: Colors.white),
        ),
        colorScheme: ColorScheme.dark(
          brightness: Brightness.dark,
          primary: Colors.grey[800]!,
          onPrimary: Colors.white,
          secondary: Colors.grey[700]!,
          onSecondary: Colors.grey.shade300,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor:
                WidgetStateProperty.resolveWith((states) => Colors.white),
          ),
        ),
        textTheme: TextTheme(
          bodyLarge: GoogleFonts.lato(
            textStyle: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          bodyMedium: GoogleFonts.lato(
            textStyle: const TextStyle(fontSize: 15, color: Colors.white),
          ),
          bodySmall: GoogleFonts.lato(
            textStyle: const TextStyle(fontSize: 12, color: Colors.white),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        snackBarTheme: const SnackBarThemeData(backgroundColor: Colors.grey, actionTextColor: Colors.black),
      ),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home: MainScreen(
        setThemeMode: setThemeMode,
      ),
    );
  }
}
