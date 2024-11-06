import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColor {
  AppColor._();
  static ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: Color(0xFFFFFFFF));
  static const Color bgColor = Color(0xFF313131);
  static const Color debug = Color(0xFFFF0000);
    static const Color debug2 = Color(0xFF00FF00);


  static const Color textColor = Color(0xFFFFFFFF);
  static const Gradient linearGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [
      Color(0xffff9a9e),
      Color(0xfffad0c4),
      Color(0xfffad0c4),
     ],
   );
}

class AppText {
  AppText._();
  static TextTheme textTheme = const TextTheme(
      // displayLarge: const TextStyle(
      //   fontSize: 72,
      //   fontWeight: FontWeight.bold,
      //   color: AppColor.textColor
      // ),
      
      // bodyMedium: GoogleFonts.merriweather(),
      // displaySmall: GoogleFonts.pacifico(),
    );

  static TextStyle title = GoogleFonts.lato(
    fontSize: 50,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    color: AppColor.debug
  );

  // static TextStyle h2 = GoogleFonts.lato(
  //   textStyle: textTheme.titleLarge,
  //   fontWeight: FontWeight.w500,
  //   fontStyle: FontStyle.normal,
  // );
  
}