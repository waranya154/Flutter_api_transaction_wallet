import 'package:flutter/material.dart';
import 'login.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,

        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[700],

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),

        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18, color: Colors.black),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black54),
          bodySmall: TextStyle(fontSize: 14, color: Colors.black54),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            minimumSize: Size(88, 36),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[400]!, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue[600]!, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red[400]!, width: 1.5),
          ),

          fillColor: Colors.grey[50],
          filled: true,

          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),

          labelStyle: TextStyle(
            color: Colors.grey[700],
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),

          // Label เมื่อ focus
          floatingLabelStyle: TextStyle(
            color: Colors.blue[600],
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // home: LoginScreen(),
      home: LoginScreen(),
    );
  }
}
