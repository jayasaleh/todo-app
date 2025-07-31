import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/utils/size_config.dart';

class AppStyles {
  static TextStyle get headingTextStyle {
    // Pastikan SizeConfig sudah diinisialisasi di sini
    // Anda bisa menambahkan assertion untuk memastikan
    assert(
      SizeConfig.screenHeight > 0,
      'SizeConfig must be initialized before using AppStyles.',
    );
    return GoogleFonts.mcLaren(
      fontSize: SizeConfig.getProportionateScreenHeight(22),
      fontWeight: FontWeight.w400,
      color: Colors.black,
    );
  }

  static TextStyle get titleTextStyle {
    assert(
      SizeConfig.screenHeight > 0,
      'SizeConfig must be initialized before using AppStyles.',
    );
    return GoogleFonts.mcLaren(
      fontSize: SizeConfig.getProportionateScreenHeight(18),
      fontWeight: FontWeight.w400,
      color: Colors.black,
    );
  }

  static TextStyle get normalTextStyle {
    assert(
      SizeConfig.screenHeight > 0,
      'SizeConfig must be initialized before using AppStyles.',
    );
    return GoogleFonts.mcLaren(
      fontSize: SizeConfig.getProportionateScreenHeight(12),
      fontWeight: FontWeight.w100,
      color: Colors.black,
    );
  }
}
