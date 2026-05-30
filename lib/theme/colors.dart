import 'package:flutter/material.dart';

/// Central color palette for the portfolio. Dark, colorful, bold.
class AppColors {
  AppColors._();

  // Backgrounds
  static const Color bg = Color(0xFF0D0D0D); // main
  static const Color bgSection = Color(0xFF161616); // sections
  static const Color bgCard = Color(0xFF1E1E1E); // cards

  // Accents
  static const Color orange = Color(0xFFFF5C35);
  static const Color yellow = Color(0xFFFFD23F);
  static const Color teal = Color(0xFF00D4AA);
  static const Color purple = Color(0xFF7B4FFF);
  static const Color pink = Color(0xFFFF3E8A);

  // Brand accents (derived from project logos)
  static const Color leangoGreen = Color(0xFF8BC23F);
  static const Color khatabookRed = Color(0xFFE5322C);
  static const Color salikSlate = Color(0xFF6A6FA0);
  static const Color resqPurple = Color(0xFF7B57AB);
  static const Color memoPink = Color(0xFFE36AC8);
  static const Color saltTeal = Color(0xFF2E8B9E);
  static const Color muabBlue = Color(0xFF157CC0);
  static const Color libraBlue = Color(0xFF4286E6);
  static const Color wellxViolet = Color(0xFF5B32E9);

  // Text
  static const Color textPrimary = Color(0xFFF0EDE6);
  static const Color textSecondary = Color(0xFF9C9890);

  // Border
  static const Color border = Color(0x12FFFFFF); // rgba(255,255,255,0.07)
  static const Color borderStrong = Color(0x24FFFFFF);

  /// Full accent sweep (legacy rainbow) — kept for reference.
  static const List<Color> accentSweep = [
    orange,
    yellow,
    teal,
    purple,
    pink,
    orange,
  ];

  // ---- Hero ring (cohesive violet -> cyan duotone) ----
  // Symmetric so the conic gradient has no visible seam at the 0/2π join.
  static const Color ringViolet = Color(0xFF8A63FF);
  static const Color ringBlue = Color(0xFF4C8DFF);
  static const Color ringCyan = Color(0xFF00D4AA);

  /// Bright outer ring sweep.
  static const List<Color> ringSweepOuter = [
    ringViolet,
    ringBlue,
    ringCyan,
    ringBlue,
    ringViolet,
  ];

  /// Dimmer inner ring sweep — same hues, lower opacity for depth.
  static const List<Color> ringSweepInner = [
    Color(0x808A63FF),
    Color(0x804C8DFF),
    Color(0x8000D4AA),
    Color(0x804C8DFF),
    Color(0x808A63FF),
  ];
}
