import 'package:flutter/material.dart';

// Material 3 Color Scheme
const Color kPrimary = Color(0xFF6750A4);
const Color kOnPrimary = Color(0xFFFFFFFF);
const Color kPrimaryContainer = Color(0xFFEADDFF);
const Color kOnPrimaryContainer = Color(0xFF21005D);

const Color kSecondary = Color(0xFF625B71);
const Color kOnSecondary = Color(0xFFFFFFFF);
const Color kSecondaryContainer = Color(0xFFE8DEF8);
const Color kOnSecondaryContainer = Color(0xFF1D192B);

const Color kTertiary = Color(0xFF7D5260);
const Color kOnTertiary = Color(0xFFFFFFFF);
const Color kTertiaryContainer = Color(0xFFFFD8E4);
const Color kOnTertiaryContainer = Color(0xFF31111D);

const Color kSurface = Color(0xFFFEF7FF);
const Color kOnSurface = Color(0xFF1C1B1F);
const Color kSurfaceVariant = Color(0xFFE7E0EC);
const Color kOnSurfaceVariant = Color(0xFF49454F);

const Color kBackground = Color(0xFFFEF7FF);
const Color kOnBackground = Color(0xFF1C1B1F);

const Color kError = Color(0xFFBA1A1A);
const Color kOnError = Color(0xFFFFFFFF);
const Color kErrorContainer = Color(0xFFFFDAD6);
const Color kOnErrorContainer = Color(0xFF410002);

const Color kSuccess = Color(0xFF006A60);
const Color kWarning = Color(0xFF825500);
const Color kInfo = Color(0xFF0061A4);

// Custom gradient colors
const Color kGradientStart = Color(0xFF6750A4);
const Color kGradientEnd = Color(0xFF7D5260);

ThemeData appTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: kPrimary,
      onPrimary: kOnPrimary,
      primaryContainer: kPrimaryContainer,
      onPrimaryContainer: kOnPrimaryContainer,
      secondary: kSecondary,
      onSecondary: kOnSecondary,
      secondaryContainer: kSecondaryContainer,
      onSecondaryContainer: kOnSecondaryContainer,
      tertiary: kTertiary,
      onTertiary: kOnTertiary,
      tertiaryContainer: kTertiaryContainer,
      onTertiaryContainer: kOnTertiaryContainer,
      surface: kSurface,
      onSurface: kOnSurface,
      surfaceVariant: kSurfaceVariant,
      onSurfaceVariant: kOnSurfaceVariant,
      background: kBackground,
      onBackground: kOnBackground,
      error: kError,
      onError: kOnError,
      errorContainer: kErrorContainer,
      onErrorContainer: kOnErrorContainer,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: kSurface,
      foregroundColor: kOnSurface,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        color: kOnSurface,
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimary,
        foregroundColor: kOnPrimary,
        elevation: 1,
        shadowColor: Colors.black26,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: kPrimary,
        foregroundColor: kOnPrimary,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: kPrimary,
        side: const BorderSide(color: kPrimary, width: 1),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: kPrimary,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: kSurfaceVariant.withOpacity(0.3),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: kOnSurfaceVariant.withOpacity(0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: kPrimary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: kError),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      labelStyle: TextStyle(color: kOnSurfaceVariant),
      hintStyle: TextStyle(color: kOnSurfaceVariant.withOpacity(0.6)),
    ),
    cardTheme: CardThemeData(
      color: kSurface,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      surfaceTintColor: kPrimary.withOpacity(0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: kSecondaryContainer,
      labelStyle: const TextStyle(color: kOnSecondaryContainer),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: kSurface,
      selectedItemColor: kPrimary,
      unselectedItemColor: kOnSurfaceVariant,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
    ),
  );
}

Widget gradientButton({
  required String text,
  required VoidCallback onPressed,
  double? width,
  bool isLoading = false,
}) {
  return Container(
    width: width,
    height: 50,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [kGradientStart, kGradientEnd],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
          color: kPrimary.withOpacity(0.3),
          offset: const Offset(0, 4),
          blurRadius: 8,
        ),
      ],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(25),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: kOnPrimary,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  text,
                  style: const TextStyle(
                    color: kOnPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    ),
  );
}

Widget customCard({
  required Widget child,
  EdgeInsetsGeometry? padding,
  EdgeInsetsGeometry? margin,
  double? elevation,
}) {
  return Container(
    margin: margin ?? const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: kSurface,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          offset: const Offset(0, 2),
          blurRadius: elevation ?? 4,
        ),
      ],
    ),
    child: Padding(padding: padding ?? const EdgeInsets.all(16), child: child),
  );
}

Widget gradientButtonChild(String text) => Container(
  alignment: Alignment.center,
  decoration: const BoxDecoration(
    gradient: LinearGradient(colors: [kGradientStart, kGradientEnd]),
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
  child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 14),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
  ),
);
