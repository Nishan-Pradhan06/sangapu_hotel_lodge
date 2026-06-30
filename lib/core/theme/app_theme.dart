import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/// Professional wallet app theme with red as the primary color
/// Designed for trust, security, and modern aesthetics
class AppTheme {
  // Primary Colors
  static const Color primaryRed = Color(0xFF1A1A2E); // --color-primary
  static const Color primaryRedDark = Color(
    0xFF16213E,
  ); // --color-primary-light
  static const Color primaryRedLight = Color(0xFF0F3460); // --color-accent2

  // Accent Colors
  static const Color accentGold = Color(0xFFF4A261); // --color-gold
  static const Color accentTeal = Color(0xFF00B4D8); // --color-teal
  static const Color accentBlue = Color(0xFF0F3460); // --color-accent2

  // Additional Accent Colors
  static const Color accent = Color(0xFFE94560); // --color-accent
  static const Color accentDark = Color(0xFFC73650); // --color-accent-dark
  static const Color tealDark = Color(0xFF0096B5); // --color-teal-dark

  // Light Theme Surfaces
  // static const Color backgroundLight = Color(0xFFF8F9FF); // surface2
  static const Color backgroundLight = Color(0xFFf3f3f5); // surface2
  static const Color surfaceLight = Color(0xFFFFFFFF); // surface
  static const Color surfaceVariantLight = Color(0xFFF0F2FF); // surface3
  static const Color dividerLight = Color(0xFFE2E8F0); // border

  // Dark Theme Surfaces
  static const Color backgroundDark = Color(0xFF1A1A2E);
  static const Color surfaceDark = Color(0xFF16213E);
  static const Color surfaceVariantDark = Color(0xFF0F3460);
  static const Color dividerDark = Color(0xFF2D3A56);

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF1A1A2E); // lmstext
  static const Color textSecondaryLight = Color(0xFF5A6072); // text2
  static const Color textTertiaryLight = Color(0xFF9CA3B0); // text3

  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFD1D5DB);
  static const Color textTertiaryDark = Color(0xFF9CA3B0);

  // Semantic Colors
  static const Color success = Color(0xFF2EC4B6);
  static const Color warning = Color(0xFFFF9F1C);
  static const Color error = Color(0xFFE71D36);
  static const Color info = Color(0xFF00B4D8);

  /// Light Theme Configuration
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    colorScheme: const ColorScheme.light(
      primary: primaryRed,
      primaryContainer: Color(0xFFFFCDD2),
      secondary: accentGold,
      secondaryContainer: Color(0xFFFFE0B2),
      tertiary: accentTeal,
      tertiaryContainer: Color(0xFFB2DFDB),
      surface: surfaceLight,
      surfaceContainerHighest: surfaceVariantLight,
      error: error,
      onPrimary: Colors.white,
      onPrimaryContainer: Color(0xFF5D1A1A),
      onSecondary: Color(0xFF5D4037),
      onSecondaryContainer: Color(0xFF5D4037),
      onTertiary: Colors.white,
      onTertiaryContainer: Color(0xFF004D40),
      onSurface: textPrimaryLight,
      onSurfaceVariant: textSecondaryLight,
      onError: Colors.white,
      outline: dividerLight,
      shadow: Color(0x1F000000),
    ),

    scaffoldBackgroundColor: backgroundLight,

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: surfaceLight,
      foregroundColor: backgroundDark,
      elevation: 0,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
      ),
      iconTheme: IconThemeData(color: backgroundDark, size: 24),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: surfaceLight,
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryRed,
        foregroundColor: Colors.white,
        elevation: 2,
        shadowColor: primaryRed.withValues(alpha: 0.3),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryRed,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryRed,
        side: const BorderSide(color: primaryRed, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryRed,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceVariantLight,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: dividerLight, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryRed, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: error, width: 2),
      ),
      labelStyle: TextStyle(
        color: textSecondaryLight,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: TextStyle(
        color: textSecondaryLight.withValues(alpha: 0.6),
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: const TextStyle(
        color: error,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: surfaceLight,
      selectedItemColor: primaryRed,
      unselectedItemColor: textSecondaryLight,
      selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: surfaceVariantLight,
      selectedColor: primaryRed.withValues(alpha: 0.12),
      disabledColor: dividerLight,
      labelStyle: const TextStyle(
        color: textPrimaryLight,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      secondaryLabelStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),

    // Dialog Theme
    dialogTheme: DialogThemeData(
      backgroundColor: surfaceLight,
      elevation: 24,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titleTextStyle: const TextStyle(
        color: textPrimaryLight,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
      ),
      contentTextStyle: const TextStyle(
        color: textSecondaryLight,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
      ),
    ),

    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: dividerLight,
      thickness: 1,
      space: 1,
    ),

    // Icon Theme
    iconTheme: const IconThemeData(color: textPrimaryLight, size: 24),

    // List Tile Theme
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      iconColor: textSecondaryLight,
      textColor: textPrimaryLight,
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      subtitleTextStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
    ),

    // Progress Indicator Theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primaryRed,
      linearTrackColor: dividerLight,
      circularTrackColor: dividerLight,
    ),

    // Snackbar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Color(0xFF323232),
      contentTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),

    // Switch Theme
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryRed;
        }
        return Colors.grey[400];
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryRed.withValues(alpha: 0.5);
        }
        return Colors.grey[300];
      }),
    ),

    // Text Theme
    textTheme: TextTheme(
      // Display - Syne
      displayLarge: GoogleFonts.syne(
        fontSize: 57,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
        color: textPrimaryLight,
      ),

      displayMedium: GoogleFonts.syne(
        fontSize: 45,
        fontWeight: FontWeight.w700,
        color: textPrimaryLight,
      ),

      displaySmall: GoogleFonts.syne(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: textPrimaryLight,
      ),

      // Headlines - Syne
      headlineLarge: GoogleFonts.syne(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: textPrimaryLight,
      ),

      headlineMedium: GoogleFonts.syne(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: textPrimaryLight,
      ),

      headlineSmall: GoogleFonts.syne(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: textPrimaryLight,
      ),

      // Titles - Space Grotesk
      titleLarge: GoogleFonts.spaceGrotesk(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textPrimaryLight,
      ),

      titleMedium: GoogleFonts.spaceGrotesk(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        color: textPrimaryLight,
      ),

      titleSmall: GoogleFonts.spaceGrotesk(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: textPrimaryLight,
      ),

      // Body - DM Sans
      bodyLarge: GoogleFonts.dmSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.3,
        color: textPrimaryLight,
      ),

      bodyMedium: GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.2,
        color: textPrimaryLight,
      ),

      bodySmall: GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textSecondaryLight,
      ),

      // Labels - Space Grotesk
      labelLarge: GoogleFonts.spaceGrotesk(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: textPrimaryLight,
      ),

      labelMedium: GoogleFonts.spaceGrotesk(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: textSecondaryLight,
      ),

      labelSmall: GoogleFonts.spaceGrotesk(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: textSecondaryLight,
      ),
    ),
  );

  /// Dark Theme Configuration
  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    colorScheme: const ColorScheme.dark(
      primary: primaryRedLight,
      primaryContainer: primaryRedDark,
      secondary: accentGold,
      secondaryContainer: Color(0xFF795548),
      tertiary: accentTeal,
      tertiaryContainer: Color(0xFF004D40),
      surface: surfaceDark,
      surfaceContainerHighest: surfaceVariantDark,
      error: error,
      onPrimary: Colors.white,
      onPrimaryContainer: Color(0xFFFFCDD2),
      onSecondary: Colors.white,
      onSecondaryContainer: Color(0xFFFFE0B2),
      onTertiary: Colors.white,
      onTertiaryContainer: Color(0xFFB2DFDB),
      onSurface: textPrimaryDark,
      onSurfaceVariant: textSecondaryDark,
      onError: Colors.white,
      outline: dividerDark,
      shadow: Color(0x3D000000),
    ),

    scaffoldBackgroundColor: backgroundDark,

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: surfaceDark,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
      ),
      iconTheme: IconThemeData(color: Colors.white, size: 24),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: surfaceDark,
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryRedLight,
        foregroundColor: Colors.white,
        elevation: 2,
        shadowColor: primaryRedLight.withValues(alpha: 0.3),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryRedLight,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryRedLight,
        side: const BorderSide(color: primaryRedLight, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryRedLight,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceVariantDark,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: dividerDark, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryRedLight, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: error, width: 2),
      ),
      labelStyle: TextStyle(
        color: textSecondaryDark,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: TextStyle(
        color: textSecondaryDark.withValues(alpha: 0.6),
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: const TextStyle(
        color: error,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: surfaceDark,
      selectedItemColor: primaryRedLight,
      unselectedItemColor: textSecondaryDark,
      selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: surfaceVariantDark,
      selectedColor: primaryRedLight.withValues(alpha: 0.12),
      disabledColor: dividerDark,
      labelStyle: const TextStyle(
        color: textPrimaryDark,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      secondaryLabelStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),

    // Dialog Theme
    dialogTheme: DialogThemeData(
      backgroundColor: surfaceDark,
      elevation: 24,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titleTextStyle: const TextStyle(
        color: textPrimaryDark,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
      ),
      contentTextStyle: const TextStyle(
        color: textSecondaryDark,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
      ),
    ),

    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: dividerDark,
      thickness: 1,
      space: 1,
    ),

    // Icon Theme
    iconTheme: const IconThemeData(color: textPrimaryDark, size: 24),

    // List Tile Theme
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      iconColor: textSecondaryDark,
      textColor: textPrimaryDark,
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      subtitleTextStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
    ),

    // Progress Indicator Theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primaryRedLight,
      linearTrackColor: dividerDark,
      circularTrackColor: dividerDark,
    ),

    // Snackbar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: surfaceVariantDark,
      contentTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),

    // Switch Theme
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryRedLight;
        }
        return Colors.grey[600];
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryRedLight.withValues(alpha: 0.5);
        }
        return Colors.grey[700];
      }),
    ),

    // Text Theme
    textTheme: TextTheme(
      // Display - Syne
      displayLarge: GoogleFonts.syne(
        fontSize: 57,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
        color: textPrimaryDark,
      ),

      displayMedium: GoogleFonts.syne(
        fontSize: 45,
        fontWeight: FontWeight.w700,
        color: textPrimaryDark,
      ),

      displaySmall: GoogleFonts.syne(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: textPrimaryDark,
      ),

      // Headlines - Syne
      headlineLarge: GoogleFonts.syne(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: textPrimaryDark,
      ),

      headlineMedium: GoogleFonts.syne(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: textPrimaryDark,
      ),

      headlineSmall: GoogleFonts.syne(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: textPrimaryDark,
      ),

      // Titles - Space Grotesk
      titleLarge: GoogleFonts.spaceGrotesk(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textPrimaryDark,
      ),

      titleMedium: GoogleFonts.spaceGrotesk(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        color: textPrimaryDark,
      ),

      titleSmall: GoogleFonts.spaceGrotesk(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: textPrimaryDark,
      ),

      // Body - DM Sans
      bodyLarge: GoogleFonts.dmSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.3,
        color: textPrimaryDark,
      ),

      bodyMedium: GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.2,
        color: textPrimaryDark,
      ),

      bodySmall: GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textSecondaryDark,
      ),

      // Labels - Space Grotesk
      labelLarge: GoogleFonts.spaceGrotesk(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: textPrimaryDark,
      ),

      labelMedium: GoogleFonts.spaceGrotesk(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: textSecondaryDark,
      ),

      labelSmall: GoogleFonts.spaceGrotesk(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: textSecondaryDark,
      ),
    ),
  );
}
