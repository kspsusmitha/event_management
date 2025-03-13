import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // Main colors
  static const Color primaryColor = Color(0xFF1E3D59);    // Deep Blue
  static const Color accentColor = Color(0xFFFF9E2C);     // Gold
  static const Color secondaryColor = Color(0xFF0F2B43);  // Darker Blue
  
  // Dark theme background colors
  static const Color darkBackground = Color(0xFF0A1929);  // Very Dark Blue
  static const Color darkSurface = Color(0xFF132F4C);     // Dark Blue Surface
  static const Color darkCard = Color(0xFF173754);        // Card Background
  
  // Additional colors
  static const Color successColor = Color(0xFF66BB6A);    // Green
  static const Color errorColor = Color(0xFFFF5252);      // Red
  static const Color textPrimary = Color(0xFFFFFFFF);     // White
  static const Color textSecondary = Color(0xFFB8C7D9);   // Light Blue Grey

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackground,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: accentColor,
      surface: darkSurface,
      background: darkBackground,
      onPrimary: textPrimary,
      onSecondary: darkBackground,
      onSurface: textPrimary,
      onBackground: textPrimary,
    ),
    
    appBarTheme: const AppBarTheme(
      backgroundColor: darkCard,
      elevation: 0,
      iconTheme: IconThemeData(color: textPrimary),
      titleTextStyle: TextStyle(
        color: textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),

    cardTheme: CardTheme(
      color: darkCard,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
    ),

    chipTheme: ChipThemeData(
      backgroundColor: primaryColor,
      disabledColor: darkCard,
      selectedColor: accentColor,
      secondarySelectedColor: accentColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accentColor,
        foregroundColor: darkBackground,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: accentColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkCard,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: accentColor, width: 2),
      ),
      labelStyle: const TextStyle(color: textSecondary),
      hintStyle: TextStyle(color: textSecondary.withOpacity(0.7)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: darkBackground,
      selectedItemColor: accentColor,
      unselectedItemColor: textSecondary,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedIconTheme: IconThemeData(size: 28),
      unselectedIconTheme: IconThemeData(size: 24),
    ),

    tabBarTheme: TabBarTheme(
      labelColor: textPrimary,
      unselectedLabelColor: textSecondary,
      indicator: BoxDecoration(
        color: accentColor,
        borderRadius: BorderRadius.circular(20),
      ),
      labelStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    ),

    // Calendar specific theme
    timePickerTheme: TimePickerThemeData(
      backgroundColor: darkCard,
      hourMinuteShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    // Additional theme configurations
    dividerColor: darkCard,
    splashColor: accentColor.withOpacity(0.1),
    hoverColor: accentColor.withOpacity(0.05),
  );
} 