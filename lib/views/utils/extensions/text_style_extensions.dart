import 'package:flutter/material.dart';
import 'package:gem_ai/views/utils/colors.dart';

extension TextStyleExtensions on TextStyle?{

  TextStyle get whiteTextStyle => const TextStyle(color: Colors.white,fontSize: 14.0);
  TextStyle get whiteTitleTextStyle => const TextStyle(color: Colors.white,fontSize: 25.0,fontWeight: FontWeight.w800,letterSpacing: 2);
  TextStyle get blackTextStyle => const TextStyle(color: Colors.black,fontSize: 14.0);
  TextStyle get primaryTextStyle => const TextStyle(color: secondaryColor,fontSize: 14.0);

}