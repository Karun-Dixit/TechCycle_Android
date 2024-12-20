import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    primarySwatch: Colors.green, // Green is now the primary color
    scaffoldBackgroundColor: Colors.grey[200], // Keeping background light
    fontFamily: 'Montserrat Regular',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontFamily: 'Montserrat Bold',
        ),
        backgroundColor: Colors.green, // Buttons now have a green background
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: Colors.green, // AppBar is green to match the primary color
      elevation: 4,
      titleTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.white, // White text for clarity and contrast
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.green, // Green for selected item
      unselectedItemColor: Colors.grey, // Grey for unselected items
      backgroundColor: Colors.white, // White background for the bottom nav
    ),
  );
}
