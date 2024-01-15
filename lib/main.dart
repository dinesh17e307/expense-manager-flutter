import 'package:flutter/material.dart';
import 'Widgets/expenses.dart';

var kSchemeColor =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 116, 4, 145));

var kdarkSchemeColor = ColorScheme.fromSeed(
    seedColor: Color.fromARGB(255, 49, 5, 131), brightness: Brightness.dark);
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kdarkSchemeColor,
        useMaterial3: true,
        cardTheme: const CardTheme().copyWith(
            color: kdarkSchemeColor.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
      ),
      theme: ThemeData().copyWith(
          colorScheme: kSchemeColor,
          useMaterial3: true,
          appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: kSchemeColor.onPrimaryContainer,
              foregroundColor: kSchemeColor.primaryContainer),
          cardTheme: const CardTheme().copyWith(
              color: kSchemeColor.secondaryContainer,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
          textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  color: kSchemeColor.onSecondaryContainer,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kSchemeColor.primaryContainer))),
      title: 'Flutter Demo',
      home: const Expenses(),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
    );
  }
}
