import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
Widget textWidget({
  required String text,
           double fontSize = 22,
           FontWeight fontWeight= FontWeight.w600,
           Color? fontColor = Colors.black,
}){
  return Text(
    text,
    style:GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color:fontColor),);
}