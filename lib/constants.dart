import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

const white = Color(0xFFFFFFFF);
const background = Color(0xFF4BA570);
const dark = Color(0xFF202634);

final textTheme = CupertinoTextThemeData(
  textStyle: GoogleFonts.poppins(
    color: white,
    fontWeight: FontWeight.w700,
  ),
  tabLabelTextStyle: GoogleFonts.poppins(
    color: white,
    fontWeight: FontWeight.w700,
    fontSize: 11,
  ),
  navTitleTextStyle: GoogleFonts.poppins(
    color: white,
    fontWeight: FontWeight.w700,
    fontSize: 20,
  ),
  navLargeTitleTextStyle: GoogleFonts.poppins(
    color: white,
    fontWeight: FontWeight.w700,
    fontSize: 40,
  ),
);