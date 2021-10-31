import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

const String baseURL = "https://alcowatch.herokuapp.com/";
const String hash = "NE3sF6KCT1YVDupz";

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
  dateTimePickerTextStyle: GoogleFonts.poppins(
    color: dark,
    fontWeight: FontWeight.w700,
    fontSize: 22,
  ),
);
const Color canvas = white;
const Color black = Color(0xFF000000);
const Color lightGray = Color(0xFFD3D3D3);
const Color gray = Color(0xFFA3A3A3);
const Color blue = Color(0xFF15A8D7);
const Color green = Color.fromRGBO(0, 223, 100, 1);
const Color darkGreen = Color(0xFF43915D);
const Color purple = Color(0xFFCB11F0);

const int memoryTime = 15;
const int maxTries = 3;