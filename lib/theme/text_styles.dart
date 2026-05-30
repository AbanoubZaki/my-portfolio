import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

/// Typography: Syne for headings, DM Sans for body.
class AppText {
  AppText._();

  // ---- Headings (Syne) ----
  // Name uses Sora — Syne's vertical metrics read as squashed at display size.
  static TextStyle heroName(double size) => GoogleFonts.sora(
        fontSize: size,
        fontWeight: FontWeight.w800,
        height: 1.08,
        letterSpacing: -1.0,
        color: AppColors.textPrimary,
      );

  static TextStyle sectionTitle(double size) => GoogleFonts.syne(
        fontSize: size,
        fontWeight: FontWeight.w800,
        height: 1.05,
        letterSpacing: -0.5,
        color: AppColors.textPrimary,
      );

  static TextStyle cardTitle(double size) => GoogleFonts.syne(
        fontSize: size,
        fontWeight: FontWeight.w700,
        height: 1.1,
        color: AppColors.textPrimary,
      );

  static TextStyle logo = GoogleFonts.syne(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
      );

  static TextStyle monogram(double size) => GoogleFonts.syne(
        fontSize: size,
        fontWeight: FontWeight.w800,
        letterSpacing: 2,
        color: AppColors.textPrimary,
      );

  // ---- Body (DM Sans) ----
  static TextStyle subtitle(double size) => GoogleFonts.dmSans(
        fontSize: size,
        fontWeight: FontWeight.w300,
        color: AppColors.textSecondary,
        letterSpacing: 0.5,
      );

  static TextStyle body(double size) => GoogleFonts.dmSans(
        fontSize: size,
        fontWeight: FontWeight.w400,
        height: 1.7,
        color: AppColors.textSecondary,
      );

  static TextStyle bodyStrong(double size) => GoogleFonts.dmSans(
        fontSize: size,
        fontWeight: FontWeight.w500,
        height: 1.6,
        color: AppColors.textPrimary,
      );

  static TextStyle label(double size) => GoogleFonts.dmSans(
        fontSize: size,
        fontWeight: FontWeight.w500,
        letterSpacing: 2.5,
        color: AppColors.textSecondary,
      );

  static TextStyle chip = GoogleFonts.dmSans(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      );

  static TextStyle button = GoogleFonts.dmSans(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.3,
      );

  static TextStyle navLink = GoogleFonts.dmSans(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );
}
