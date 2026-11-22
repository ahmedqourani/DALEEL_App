import 'package:flutter/material.dart';

/// ---------------------------------------------------------------------------
/// AppColors - every color in the app lives here.
/// Change a value once and the whole app updates.
/// Approved petrol-blue identity with lime accents.
/// ---------------------------------------------------------------------------
class AppColors {
  AppColors._(); // no instances - static access only

  /// Dark petrol - primary buttons, splash background, selected states.
  static const Color primary = Color(0xFF075E6B);

  /// Medium petrol - promo banners, subtitles ("available now for swap").
  static const Color primaryBanner = Color(0xFF075E6B);

  /// Retained green add-listing action, independently from the brand banner.
  static const Color addAction = Color(0xFF809028);
  static const Color bright = Color(0xFF8CD6DF);

  /// Bright petrol accent - highlights, small icons.
  static const Color accent = Color(0xFFC5E86C);

  /// Light petrol - category tiles, bottom nav bar, filled chips/code boxes.
  static const Color primaryLight = Color(0xFFDDECEF);

  /// Cream page background (Figma style name: "bage color").
  static const Color background = Color(0xFFF3F7F8);

  /// Cards and text fields are white.
  static const Color card = Colors.white;

  /// Main text - near black.
  static const Color text = Color(0xFF142B34);

  /// Secondary text - gray with an petrol tint.
  static const Color textSecondary = Color(0xFF5B737A);

  /// Field/card border (Figma style name: "stro").
  static const Color stroke = Color(0xFFD8E5E8);

  /// Destructive actions (Log out, Delete).
  static const Color danger = Color(0xFFC83838);

  /// Success green - "Available" status dots.
  static const Color success = Color(0xFF4C8C2B);

  /// Pending/amber - "Pending" status chips.
  static const Color warning = Color(0xFFB8860B);
}

/// ---------------------------------------------------------------------------
/// AppTheme - builds the ThemeData used by MaterialApp.
/// Typography: Zain (bundled TTFs, see pubspec fonts section) - Arabic-first
/// typeface used for every text style in the app, Arabic and Latin alike.
/// ---------------------------------------------------------------------------
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData.light(useMaterial3: true);
    // Latin letters and digits render in Poppins; Poppins has no Arabic
    // glyphs, so Arabic falls back to Zain. One theme covers both scripts.
    final textTheme = base.textTheme.apply(
      fontFamily: 'Poppins',
      fontFamilyFallback: const ['Zain'],
      bodyColor: AppColors.text,
      displayColor: AppColors.text,
    );

    return base.copyWith(
      canvasColor: AppColors.card,
      dialogTheme: const DialogThemeData(
        backgroundColor: AppColors.card,
        surfaceTintColor: Colors.transparent,
      ),
      popupMenuTheme: const PopupMenuThemeData(
        color: AppColors.card,
        surfaceTintColor: Colors.transparent,
      ),
      menuTheme: const MenuThemeData(
        style: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(AppColors.card),
          surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
        ),
      ),
      dropdownMenuTheme: const DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(AppColors.card),
          surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
        ),
      ),
      datePickerTheme: const DatePickerThemeData(
        backgroundColor: AppColors.card,
        surfaceTintColor: Colors.transparent,
      ),
      timePickerTheme: const TimePickerThemeData(
        backgroundColor: AppColors.card,
      ),
      dividerColor: const Color(0xFFD8E5E8),
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.card,
        modalBackgroundColor: AppColors.card,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
      tabBarTheme: const TabBarThemeData(
        dividerHeight: 0,
        labelStyle: TextStyle(
          fontFamily: 'Zain',
          fontSize: 17,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: TextStyle(fontFamily: 'Zain', fontSize: 17),
      ),
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.accent,
        onSecondary: AppColors.text,
        surface: AppColors.card,
        onSurface: AppColors.text,
        onSurfaceVariant: AppColors.textSecondary,
        error: AppColors.danger,
      ),
      textTheme: textTheme,

      // AppBars are flat, pale blue, with centered dark titles (like the Figma).
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.text,
        elevation: 0,
        centerTitle: true,
      ),

      // Pill-shaped petrol buttons (radius from Figma: fully rounded).
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.text,
          minimumSize: const Size.fromHeight(52),
          side: const BorderSide(color: AppColors.stroke),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      // White, fully rounded text fields with a light border.
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.card,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.stroke),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.stroke),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondary,
        ),
      ),

      cardTheme: CardThemeData(
        color: AppColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.stroke),
        ),
      ),

      chipTheme: base.chipTheme.copyWith(
        backgroundColor: AppColors.primaryLight,
        selectedColor: AppColors.accent,
        labelStyle: textTheme.bodySmall?.copyWith(color: AppColors.text),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide.none,
      ),

      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.primary,
        contentTextStyle: TextStyle(color: Colors.white),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Dark palette: deep petrol-charcoal surfaces, same brand petrol accents.
  /// Glass surfaces, blobs and text colors follow Theme.brightness.
  static const Color _darkBackground = Color(0xFF0D1D25);
  static const Color _darkCard = Color(0xFF1B252A);
  static const Color _darkText = Color(0xFFF2F7F8);
  static const Color _darkTextSecondary = Color(0xFFB2C8CF);
  static const Color _darkStroke = Color(0xFF35444B);

  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);
    final textTheme = base.textTheme.apply(
      fontFamily: 'Poppins',
      fontFamilyFallback: const ['Zain'],
      bodyColor: _darkText,
      displayColor: _darkText,
    );

    return base.copyWith(
      canvasColor: _darkCard,
      menuTheme: const MenuThemeData(
        style: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(_darkCard),
          surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
        ),
      ),
      timePickerTheme: const TimePickerThemeData(backgroundColor: _darkCard),
      dividerColor: const Color(0xFFD8E5E8),
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: _darkCard,
        modalBackgroundColor: _darkCard,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
      tabBarTheme: const TabBarThemeData(
        dividerHeight: 0,
        labelStyle: TextStyle(
          fontFamily: 'Zain',
          fontSize: 17,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: TextStyle(fontFamily: 'Zain', fontSize: 17),
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: _darkCard,
        surfaceTintColor: Colors.transparent,
      ),
      popupMenuTheme: const PopupMenuThemeData(
        color: _darkCard,
        surfaceTintColor: Colors.transparent,
      ),
      datePickerTheme: const DatePickerThemeData(
        backgroundColor: _darkCard,
        surfaceTintColor: Colors.transparent,
      ),
      dropdownMenuTheme: const DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(_darkCard),
          surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.bright,
        selectionColor: Color(0x668CD6DF),
        selectionHandleColor: AppColors.bright,
      ),
      scaffoldBackgroundColor: _darkBackground,
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
        primary: const Color(0xFF8CD6DF),
        secondary: AppColors.accent,
        onSecondary: AppColors.text,
        surface: _darkCard,
        onSurface: _darkText,
        onSurfaceVariant: _darkTextSecondary,
        error: AppColors.danger,
      ),
      textTheme: textTheme,

      appBarTheme: const AppBarTheme(
        backgroundColor: _darkBackground,
        foregroundColor: _darkText,
        elevation: 0,
        centerTitle: true,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _darkText,
          minimumSize: const Size.fromHeight(52),
          side: const BorderSide(color: _darkStroke),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _darkCard,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: _darkStroke),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: _darkStroke),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(color: _darkTextSecondary),
      ),

      cardTheme: CardThemeData(
        color: _darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: _darkStroke),
        ),
      ),

      chipTheme: base.chipTheme.copyWith(
        backgroundColor: AppColors.primaryLight,
        selectedColor: AppColors.accent,
        labelStyle: textTheme.bodySmall?.copyWith(color: AppColors.text),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide.none,
      ),

      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.primary,
        contentTextStyle: TextStyle(color: Colors.white),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
