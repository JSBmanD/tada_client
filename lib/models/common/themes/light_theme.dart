import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tada_client/models/common/themes/base_theme.dart';

/// Светлая тема
class LightTheme implements BaseTheme {
  LightTheme() {
    this.backgroundColor = Color(0xFFF7F8FB);
    this.accentColor = Color(0xFF0071DA);
    this.primaryTextColor = Color(0xFF232429);
    this.secondaryTextColor = Color(0xFF6B6B7E);
    this.secondary2TextColor = Color(0xFFEEEFF3);

    this.subhead1TextStyle = GoogleFonts.manrope(
      fontSize: 18,
      color: primaryTextColor,
      fontWeight: FontWeight.w600,
      height: 1.2,
    );

    this.subhead2TextStyle = GoogleFonts.manrope(
      fontSize: 13,
      color: primaryTextColor,
      fontWeight: FontWeight.w600,
      height: 1.4,
      letterSpacing: -0.005,
    );

    this.body1TextStyle = GoogleFonts.manrope(
      fontSize: 16,
      color: primaryTextColor,
      fontWeight: FontWeight.normal,
      height: 1.45,
    );

    this.body2TextStyle = GoogleFonts.manrope(
      fontSize: 13,
      color: primaryTextColor,
      fontWeight: FontWeight.normal,
      height: 1.4,
      letterSpacing: -0.005,
    );

    this.headline1TextStyle = GoogleFonts.manrope(
      fontSize: 32,
      color: primaryTextColor,
      fontWeight: FontWeight.w800,
      height: 1.25,
      letterSpacing: -0.005,
    );
  }

  @override
  Color primaryTextColor;

  @override
  Color secondaryTextColor;

  @override
  Color secondary2TextColor;

  @override
  Color accentColor;

  @override
  Color backgroundColor;

  @override
  TextStyle body1TextStyle;

  @override
  TextStyle body2TextStyle;

  @override
  TextStyle headline1TextStyle;

  @override
  TextStyle subhead2TextStyle;

  @override
  TextStyle subhead1TextStyle;
}
