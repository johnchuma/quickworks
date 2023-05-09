import 'package:flutter/material.dart';

Widget muted(String text,
    {double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    TextAlign? textAlign}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
        fontSize: fontSize ?? 12,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? Colors.black.withOpacity(0.5)),
  );
}
