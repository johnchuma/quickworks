import 'package:flutter/material.dart';

Widget heading(String text,
    {double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    TextAlign? textAlign,
    int? maxLines}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
        fontSize: fontSize ?? 18,
        fontWeight: fontWeight ?? FontWeight.bold,
        color: color ?? Colors.black),
  );
}
