import 'package:flutter/material.dart';

Widget paragraph(String text,
    {double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    TextAlign? textAlign,
    TextDecoration? textDecoration}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
        fontSize: fontSize ?? 13,
        decoration: textDecoration ?? TextDecoration.none,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? Colors.black),
  );
}
