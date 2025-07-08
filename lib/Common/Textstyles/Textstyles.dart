import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saloon_app/Common/common_colors.dart';

class FontStyles{

  static TextStyle w400_24_black = GoogleFonts.mulish(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black
  );
  static TextStyle bold_20_commonColor = GoogleFonts.mulish(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: common_clr
  );
  static TextStyle w300_15_black = GoogleFonts.mulish(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: Colors.black
  );

  static TextStyle w400_15_black = GoogleFonts.mulish(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: Colors.black38
  );

  static TextStyle bold_24_black = GoogleFonts.mulish(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.black
  );

  static TextStyle w700_15_black = GoogleFonts.mulish(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      color: common_clr
  );

  static TextStyle w700_15_blackbold = GoogleFonts.mulish(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      color: Colors.black
  );

  static TextStyle w700_15_white = GoogleFonts.mulish(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      color: Colors.white
  );

  static TextStyle w400_20_white = GoogleFonts.mulish(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white
  );

  static TextStyle w700_20_grey = GoogleFonts.mulish(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Colors.grey
  );

  static TextStyle w700_15_grey = GoogleFonts.mulish(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      color: Colors.grey
  );

  static TextStyle w400_18_grey = GoogleFonts.mulish(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Colors.black54
  );

}